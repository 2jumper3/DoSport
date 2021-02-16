//
//  SportGroundSelectionListView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import UIKit

final class SportGroundSelectionListView: UIView {
    
    private let topSeparatorView = DSSeparatorView()

    private lazy var tableView: UITableView = {
        $0.registerClass(TableViewSportGroundSelectionCell.self)
        $0.separatorColor = Colors.dirtyBlue
        $0.backgroundColor = Colors.darkBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView(frame: .zero, style: .plain))

    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        addSubviews(topSeparatorView, tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        topSeparatorView.snp.makeConstraints {
            $0.top.equalTo(safeAreaInsets.top).offset(1)
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(topSeparatorView.snp.bottom).offset(20)
            $0.bottom.equalTo(safeAreaInsets.bottom).offset(-20)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        [topSeparatorView, tableView].forEach { $0.snp.makeConstraints { $0.centerX.equalToSuperview() } }
    }
}

//MARK: - Public Methods

extension SportGroundSelectionListView {
    
    func udpateTableDataSource(dataSource: (UITableViewDataSource & UITableViewDelegate)) {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.reloadData()
        layoutIfNeeded()
    }
}
