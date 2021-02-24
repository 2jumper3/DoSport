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
        
        setupCalendarView()
        
        collectionView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.bottom.equalTo(saveButton.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(calendarView.frame.maxY+10)
        }
        
        let buttonBottom = UIDevice.deviceSize == .small ? 10 : 25
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaInsets.bottom).offset(-buttonBottom)
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalTo(48)
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
        let calendarWidth: CGFloat = UIDevice.deviceSize == .small ? 375 : 400
        let calendarHeight: CGFloat = UIDevice.deviceSize == .small ? 250 : 320
        let xOffset = (bounds.width - calendarWidth) / 2
        
        calendarView.frame = CGRect(
            x: xOffset,
            y: safeAreaInsets.top + 10,
            width: calendarWidth,
            height: calendarHeight
        )
        calendarView.backgroundColor = Colors.darkBlue
        calendarView.appearance.headerTitleColor = .white
        calendarView.appearance.todayColor = Colors.lightBlue
        calendarView.appearance.selectionColor = Colors.mainBlue
        calendarView.appearance.weekdayTextColor = Colors.mainBlue
        calendarView.appearance.titleDefaultColor = .white
        calendarView.appearance.titleSelectionColor = .white
        calendarView.appearance.titleWeekendColor = Colors.textError
        calendarView.appearance.headerSeparatorColor = Colors.dirtyBlue
        calendarView.appearance.titlePlaceholderColor = Colors.mainBlue
    }
}

//MARK: Action

@objc private extension DateSelectionView {
    
    func handleSaveButton() {
        delegate?.saveButtonClicked()
    }
}

//MARK: - FSCalendarDelegate,  FSCalendarDateSource -

extension DateSelectionView: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        delegate?.calendarView(didSelect: date)
    }
}
