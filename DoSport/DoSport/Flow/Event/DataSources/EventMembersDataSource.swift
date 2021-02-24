//
//  EventMembersDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/02/2021.
//

import UIKit

protocol EventMembersDataSourceDelegate: class {
    func membersTableViewScrolled()
}

final class EventMembersDataSource: NSObject {
    
    weak var delegate: EventMembersDataSourceDelegate?
    
    var viewModels: [Member]
    
    init(viewModels: [Member] = []) {
        self.viewModels = viewModels
        super.init()
    }
}

//MARK: - UITableViewDataSource -

extension EventMembersDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let viewModel = viewModels[indexPath.row]
        
        let cell: TableViewMemberCell = tableView.cell(forRowAt: indexPath)
//        cell.memberNameLabel.text =
//        cell.memberAvatarImageView.image =
//        cell.commentCreatedTimeLabel.text =
        
        return cell
    }
}

//MARK: - UITableViewDelegate -

extension EventMembersDataSource: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.membersTableViewScrolled()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.deviceSize == .small ? 40 : 45
    }
}


