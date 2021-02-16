//
//  DateSelectionView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit
import FSCalendar

final class DateSelectionView: UIView, FSCalendarDelegate, FSCalendarDataSource {
    
    private let topSeparatorView = DSSeparatorView()
    
    private(set) var calendarView = FSCalendar()
    
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
    
    private(set) lazy var saveButton = CommonButton(title: Texts.DateSelection.save, state: .disabled)

    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        setupCalendarView()
        
        addSubviews(calendarView, topSeparatorView, collectionView, saveButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        topSeparatorView.snp.makeConstraints {
            $0.top.equalTo(safeAreaInsets.top).offset(1)
            $0.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.bottom.equalTo(saveButton.snp.top).offset(-5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(snp.height).multipliedBy(0.4)
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaInsets.bottom).offset(-50) // FIXME: !
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
        }
    }
}

//MARK: - Public Methods

extension DateSelectionView {
    
    func udpateTableDataSource(dataSource: (UICollectionViewDataSource & UICollectionViewDelegate)) {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
}

//MARK: - Private method

private extension DateSelectionView {
    
    func setupCalendarView() {
        calendarView.frame = CGRect(
            x: 0,
            y: safeAreaInsets.top + 10,
            width: 375,
            height: 250.0
        )
        
        calendarView.backgroundColor = Colors.darkBlue
        calendarView.appearance.headerTitleColor = .white
        calendarView.appearance.todayColor = Colors.lightBlue
        calendarView.appearance.selectionColor = Colors.mainBlue
        calendarView.appearance.weekdayTextColor = Colors.mainBlue
        calendarView.appearance.titleDefaultColor = Colors.dirtyBlue
        calendarView.appearance.titleSelectionColor = .white
        calendarView.appearance.titleWeekendColor = Colors.dirtyBlue
    }
}
