//
//  UserSupportSettingsView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

protocol UserSupportSettingsViewDelegate: class { }
    
final class UserSupportSettingsView: UIView {
    
    weak var delegate: UserSupportSettingsViewDelegate?
    
    private let tabBarHeight = UIDevice.getDeviceRelatedTabBarHeight()
    
    //MARK: Outlets
    
    private let tableView: UITableView = {
        $0.backgroundColor = Colors.darkBlue
        $0.showsVerticalScrollIndicator = false
        $0.separatorColor = Colors.dirtyBlue
        $0.registerClass(RegularTableCellWithPointer.self)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView(frame: .zero, style: .grouped))

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
            $0.width.equalToSuperview().multipliedBy(0.92)
        }
    }
}

//MARK: Public API

extension UserSupportSettingsView {
    
    func updateCollectionDataSource(dateSource: (UITableViewDataSource & UITableViewDelegate)) {
        tableView.delegate = dateSource
        tableView.dataSource = dateSource
        tableView.reloadData()
        layoutIfNeeded()
    }
}
