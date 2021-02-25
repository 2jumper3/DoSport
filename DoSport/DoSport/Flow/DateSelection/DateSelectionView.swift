//
//  DateSelectionView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit
import FSCalendar

protocol DateSelectionViewDelegate: class {
    func saveButtonClicked()
    func calendarView(didSelect date: Date)
}

final class DateSelectionView: UIView {
    
    weak var delegate: DateSelectionViewDelegate?
    private var selectedDate: Date?
    private var calendarWidth: CGFloat = 375
    
    //MARK: Outlets
    
    private let calendarView = FSCalendar()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Colors.darkBlue
        collectionView.registerClass(CollectionViewHoursCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var saveButton = CommonButton(title: Texts.DateSelection.save, state: .disabled)

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        calendarView.delegate = self
        
        saveButton.addTarget(self, action: #selector(handleSaveButton))
        
        addSubviews(calendarView, collectionView, saveButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var saveButtonsHeight: CGFloat = 48
        var buttonBottom: CGFloat = 15
        
        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2:
            saveButtonsHeight = 46
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini:
            buttonBottom = 20
            calendarWidth = 400
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max:
            buttonBottom = 40
            calendarWidth = 420
            saveButtonsHeight = 50
        default: break
        }
        
        setupCalendarView()
        
        collectionView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.bottom.equalTo(saveButton.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(calendarView.frame.maxY+10)
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaInsets.bottom).offset(-buttonBottom)
            $0.width.equalToSuperview().multipliedBy(0.92)
            $0.height.equalTo(saveButtonsHeight)
            $0.centerX.equalToSuperview()
        }
    }
}

//MARK: Public API

extension DateSelectionView {
    
    func udpateTableDataSource(dataSource: (UICollectionViewDataSource & UICollectionViewDelegate)) {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
    
    func bindSaveButton(state: CommonButtonState) {
        saveButton.bind(state: state)
    }
    
    func getSaveButtonState() -> CommonButtonState {
        return saveButton.getState()
    }
}

//MARK: Private API

private extension DateSelectionView {
    
    func setupCalendarView() {
        let calendarHeight: CGFloat = UIDevice.deviceSize == .small ? 250 : 320
        let xOffset = (bounds.width - calendarWidth) / 2
        
        calendarView.frame = CGRect(
            x: xOffset,
            y: safeAreaInsets.top + 10,
            width: self.calendarWidth,
            height: calendarHeight
        )
        
        calendarView.locale = NSLocale() as Locale
        calendarView.backgroundColor = Colors.darkBlue
        calendarView.appearance.headerTitleColor = .white
        calendarView.appearance.todayColor = Colors.lightBlue
        calendarView.appearance.weekdayTextColor = Colors.mainBlue
        calendarView.appearance.titleSelectionColor = .white
        calendarView.appearance.headerSeparatorColor = Colors.dirtyBlue
        calendarView.appearance.titlePlaceholderColor = Colors.mainBlue
        calendarView.appearance.titleFont = Fonts.sfProRegular(size: 16)
    }
}

//MARK: Action

@objc private extension DateSelectionView {
    
    func handleSaveButton() {
        delegate?.saveButtonClicked()
    }
}

//MARK: - FSCalendarDelegate -

extension DateSelectionView: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if date.removeTimeStamp?.compare(Date().removeTimeStamp!) == .orderedAscending {
            /// Past date was selected ----
            /// Selection colour will not change from default colour so user will understand that past days are not
            ///  available to be selected
            calendar.appearance.selectionColor = .clear
            calendar.appearance.titleSelectionColor = Colors.dirtyBlue
            return
        }
        /// ELSE. Upcomming date or current date  was selected
        
        let currentMonth = Calendar.current(.month, for: calendar.currentPage)
        let selectedDateMonth = Calendar.current(.month, for: date)
        
        /// If user selects date out of current month then show him selected date's month
        if selectedDateMonth != currentMonth {
            calendar.setCurrentPage(date, animated: true)
            self.selectedDate = date
            delegate?.calendarView(didSelect: date)
            return
        }
        
        /// If user selected day and selects it again we should deselect selected date. And set it nil after deselection
        if let selectedDate = selectedDate, selectedDate == date {
            calendar.deselect(date)
            self.selectedDate = nil
            
            /// And if date is selected then send to VC selected date,
            /// otherwise send to VC current date
            delegate?.calendarView(didSelect: Date())
        } else {
            if selectedDate != nil {
                calendar.deselect(selectedDate!)
                self.selectedDate = nil
            }
            
            self.selectedDate = date
            delegate?.calendarView(didSelect: date)
        }
        
       
        calendarView.appearance.selectionColor = Colors.lightBlue
        calendar.appearance.titleSelectionColor = .white
    }
}

//MARK: - FSCalendarDelegateAppearance -

extension DateSelectionView: FSCalendarDelegateAppearance {
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        /// In order to reload date colours of previous month and current
        calendar.reloadData()
    }
    
    /// Setup calendarView's each date title colour by `past or future months` / `current month ` / `current day`
    func calendar(
        _ calendar: FSCalendar,
        appearance: FSCalendarAppearance,
        titleDefaultColorFor date: Date
    ) -> UIColor? {
        if date.removeTimeStamp?.compare(Date().removeTimeStamp!) == .orderedAscending {
            /// Set past dates color
            
            return Colors.dirtyBlue
        } else if date.removeTimeStamp!.compare(Date().removeTimeStamp!) == .orderedDescending {
            /// Set upcomming dates
            
            let currentPage = calendarView.currentPage
            
            let month = Calendar.current(.month, for: date),
                year = Calendar.current(.year, for: date)
            let currnentMonth = Calendar.current(.month, for: currentPage),
                currnentYear = Calendar.current(.year, for: currentPage)
            
            /// Set only current month's dates color to white,  otherwise set dirtyBlue
            if (month == currnentMonth) && (year == currnentYear) {
                return .white
            } else {
                return Colors.dirtyBlue
            }
        } else {
            /// Set current date color
            return .white
        }
    }
}

extension Calendar {
    
    static func current(_ component: Component, for date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(component, from: date)
    }
}
