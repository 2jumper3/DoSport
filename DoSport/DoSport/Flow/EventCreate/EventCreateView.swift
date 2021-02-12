//
//  EventCreateView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

final class EventCreateView: UIView {
    
    private let navSeperatorView = DSSeparatorView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.registerClass(TextViewCell.self)
        tableView.registerClass(EventTypeCell.self)
        tableView.registerClass(SelectionCell.self)
        tableView.registerClass(MembersCountCell.self)
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorColor = Colors.dirtyBlue
        tableView.backgroundColor = Colors.darkBlue
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private(set) lazy var createButton = CommonButton(title: Texts.EventCreate.create, state: .disabled)

    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        addSubviews(navSeperatorView, tableView, createButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        navSeperatorView.snp.makeConstraints {
            $0.centerX.width.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(safeAreaInsets.top).offset(10)
        }
        
        tableView.snp.makeConstraints {
            $0.centerX.width.equalToSuperview()
            $0.top.equalTo(navSeperatorView.snp.bottom)
            $0.bottom.equalTo(createButton.snp.top).offset(-25)
        }
        
        createButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.89)
            $0.height.equalTo(42)
            $0.bottom.equalTo(safeAreaInsets.bottom).offset(-30)
        }
    }
}

//MARK: - Public Methods

extension EventCreateView {
    
    func updateTableDataSource(dataSource: (UITableViewDataSource & UITableViewDelegate)) {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.reloadData()
        layoutIfNeeded()
    }
}

