//
//  CollectionViewMemberCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit

final class CollectionViewMemberCell: UICollectionViewCell {
    
    private let tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = false
        $0.backgroundColor = Colors.darkBlue
        $0.separatorStyle = .none
        $0.registerClass(TableViewMemberCell.self)
        return $0
    }(UITableView(frame: .zero, style: .plain))
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        contentView.addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.snp.makeConstraints {  $0.edges.equalToSuperview() }
    }
}

//MARK: Public API

extension CollectionViewMemberCell {
    
    func updataTAbleDataSource(dataSource: (UITableViewDataSource & UITableViewDelegate)) {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()
        layoutIfNeeded()
    }
    
    func getTableView() -> UITableView {
        return tableView
    }
}
