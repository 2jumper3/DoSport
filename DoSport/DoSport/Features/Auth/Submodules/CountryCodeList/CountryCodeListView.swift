//
//  CountryCodeListView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import UIKit

final class CountryCodeListView: UIView {
    
    private let navBarSeparatorView = DSSeparatorView()
    
    private lazy var tableView: UITableView = {
        $0.registerClass(TableViewCountryCell.self)
        $0.backgroundColor = Colors.darkBlue
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        return $0
    }(UITableView())
    
    private let emptyView: DSEmptyView = {
        $0.isHidden = true
        return $0
    }(DSEmptyView())
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        addSubviews(navBarSeparatorView, tableView, emptyView)
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
        
        emptyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//MARK: - Public methods

extension CountryCodeListView {
    
    func updateTableViewData(dataSource: (UITableViewDelegate & UITableViewDataSource)) {
        if !emptyView.isHidden || tableView.isHidden {
            emptyView.isHidden = true
            tableView.isHidden = false
        }
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()
    }
    
    func updateView() {
        tableView.isHidden = true
        emptyView.isHidden = false
    }
}
