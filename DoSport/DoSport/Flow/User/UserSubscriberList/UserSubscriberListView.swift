//
//  UserSubscriberListView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import UIKit

protocol UserSubscriberListViewDelegate: class {

}
    
final class UserSubscriberListView: UIView {
    
    weak var delegate: UserSubscriberListViewDelegate?
    
    private let tabBarHeight = UIDevice.getDeviceRelatedTabBarHeight()
    
    //MARK: Outlets
    
    private let tableView: UITableView = {
        $0.backgroundColor = Colors.darkBlue
        $0.registerClass(TableViewMemberCell.self)
        $0.registerHeaderFooter(EventTableChatHeaderView.self)
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView(frame: .zero, style: .plain))

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-tabBarHeight-10)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
    }
}

//MARK: Public API

extension UserSubscriberListView {
    
    func updateCollectionDataSource(dateSource: (UITableViewDataSource & UITableViewDelegate)) {
        tableView.delegate = dateSource
        tableView.dataSource = dateSource
        tableView.reloadData()
        layoutIfNeeded()
    }
}

