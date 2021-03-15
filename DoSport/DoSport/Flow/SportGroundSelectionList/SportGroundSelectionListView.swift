//
//  SportGroundSelectionListView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import UIKit

final class SportGroundSelectionListView: UIView {

    private lazy var tableView: UITableView = {
        $0.registerClass(SportGroundSelectionTableCell.self)
        $0.separatorColor = Colors.dirtyBlue
        $0.backgroundColor = Colors.darkBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UITableView(frame: .zero, style: .plain))

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        addSubviews(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaInsets.top).offset(10)
            $0.bottom.equalTo(safeAreaInsets.bottom).offset(-35)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
        }
    }
}

//MARK: Public API

extension SportGroundSelectionListView {
    
    func udpateTableDataSource(dataSource: (UITableViewDataSource & UITableViewDelegate)) {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.reloadData()
        layoutIfNeeded()
    }
}
