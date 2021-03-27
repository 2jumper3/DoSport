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
}

final class DateSelectionView: UIView {
    
    weak var delegate: DateSelectionViewDelegate?
    private var calendarWidth: CGFloat = 375
    private var calendarHeight: CGFloat = 250
    
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
    
    private lazy var saveButton = DSCommonButton(title: Texts.DateSelection.save, state: .disabled)

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
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
            calendarHeight = 300
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max:
            buttonBottom = 40
            calendarWidth = 420
            calendarHeight = 320
            saveButtonsHeight = 50
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
    
    func bindSaveButton(state: DSCommonButtonState) {
        saveButton.bind(state: state)
    }
    
    func getSaveButtonState() -> DSCommonButtonState {
        return saveButton.getState()
    }
    
    func setCalendarDelegate(_ delegate: FSCalendarDelegate?) {
        calendarView.delegate = delegate
    }
    
    func getCalendarCurrentPage() -> Date {
        return calendarView.currentPage
    }
}

//MARK: Private API

private extension DateSelectionView {
    
    func setupCalendarView() {
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
        calendarView.appearance.selectionColor = Colors.lightBlue
        calendarView.appearance.titleSelectionColor = .white
        calendarView.appearance.headerSeparatorColor = Colors.dirtyBlue
        calendarView.appearance.titlePlaceholderColor = Colors.mainBlue
        calendarView.appearance.titleFont = Fonts.sfProRegular(size: 16)
    }
}

//MARK: Actions

@objc private extension DateSelectionView {
    
    func handleSaveButton() {
        delegate?.saveButtonClicked()
    }
}
