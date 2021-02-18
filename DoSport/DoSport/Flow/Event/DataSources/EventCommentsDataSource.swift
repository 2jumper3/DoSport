//
//  EventCommentsDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/02/2021.
//

import UIKit

protocol EventCommentsDataSourceDelegate: class {
    func commentsTableViewScrolled()
    func tableViewReplyButtonClicked(to userName: String?)
}

final class EventCommentsDataSource: NSObject {
    
    weak var delegate: EventCommentsDataSourceDelegate?
    
    var viewModels: [Message]
    
    init(viewModels: [Message] = []) {
        self.viewModels = viewModels
        super.init()
    }
}

//MARK: - UITableViewDataSource -

extension EventCommentsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        
        let cell: TableViewCommentCell = tableView.cell(forRowAt: indexPath)
        cell.memberName = viewModel.userName
//        cell.memberAvatarImageView.image =
//        cell.commentCreatedTimeLabel.text = viewModel.createdDate
        cell.commentText = viewModel.text
        cell.onReplyButtonClicked = { [unowned self] userName in
            delegate?.tableViewReplyButtonClicked(to: userName)
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate -

extension EventCommentsDataSource: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       delegate?.commentsTableViewScrolled()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.deviceSize == .small ? 65 : 80
    }
}

