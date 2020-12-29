//
//  CountryListView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import UIKit

final class CountryListView: UIView {
    
    private let navBarSeparatorView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Colors.dirtyBlue
        return $0
    }(UIView())
    
    private lazy var tableView: UITableView = {
        $0.registerClass(CountryListTableCell.self)
        $0.backgroundColor = Colors.darkBlue
        $0.separatorStyle = .singleLine
        return $0
    }(UITableView())

    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        addSubviews(navBarSeparatorView, tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        navBarSeparatorView.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(self.safeAreaInsets.top).offset(10)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(navBarSeparatorView.snp.bottom)
            $0.width.centerX.bottom.equalToSuperview()
        }
    }
}

//MARK: - Public methods

extension CountryListView {
    func updateTableViewData(dataSource: (UITableViewDelegate & UITableViewDataSource)) {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()
    }
}
