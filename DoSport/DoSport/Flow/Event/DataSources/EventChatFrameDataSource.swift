//
//  EventChatFrameDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/02/2021.
//

import UIKit

protocol EventChatFrameDataSourceDelegate: class {
    func commentsTableViewReplyButtonClicked(to userName: String?)
    func commentsTableViewScrolled()
    func membersTableViewScrolled()
    func chatFramCollectionView(scrolledTo index: Int)
}

final class EventChatFrameDataSource: NSObject {
    
    weak var delegate: EventChatFrameDataSourceDelegate?
    
    var viewModels: [Event.EventChatCellType]
    
    private let commentsTableManager = EventCommentsDataSource()
    private let membersTableManager = EventMembersDataSource()
    
    private var commentsTableView: UITableView?
    private var membersTableView: UITableView?
    
    init(viewModels: [Event.EventChatCellType] = []) {
        self.viewModels = viewModels
        super.init()
        
        commentsTableManager.delegate = self
        membersTableManager.delegate = self
    }
}

//MARK: Public API

extension EventChatFrameDataSource {
    
    func getCommentsTableView() -> UITableView? {
        return commentsTableView
    }
    
    func getMembersTableView() -> UITableView? {
        return membersTableView
    }
}

//MARK: - UICollectionViewDataSource -

extension EventChatFrameDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cellType = viewModels[indexPath.row]
        
        let cell: UICollectionViewCell
        
        switch cellType {
        case .messages(let messages):
            commentsTableManager.viewModels = messages
            
            let commentCell: CollectionViewCommentCell = collectionView.cell(forRowAt: indexPath)
            commentCell.updataTAbleDataSource(dataSource: commentsTableManager)
            self.commentsTableView = commentCell.getTableView()
            
            cell = commentCell
        case .members(let members):
            membersTableManager.viewModels = members
            
            let memberCell: CollectionViewMemberCell = collectionView.cell(forRowAt: indexPath)
            memberCell.updataTAbleDataSource(dataSource: membersTableManager)
            self.membersTableView = memberCell.getTableView()
            
            cell = memberCell
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout -

extension EventChatFrameDataSource: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if indexPath.row == viewModels.count - 1 {
            delegate?.chatFramCollectionView(scrolledTo: indexPath.row - 1)
        } else if indexPath.row == 0 {
            delegate?.chatFramCollectionView(scrolledTo: indexPath.row + 1 )
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

//MARK: - EventCommentsDataSourceDelegate -

extension EventChatFrameDataSource: EventCommentsDataSourceDelegate {
    
    func commentsTableViewScrolled() {
        delegate?.commentsTableViewScrolled()
    }
    
    func tableViewReplyButtonClicked(to userName: String?) {
        delegate?.commentsTableViewReplyButtonClicked(to: userName)
    }
}

//MARK: - EventMembersDataSourceDelegate -

extension EventChatFrameDataSource: EventMembersDataSourceDelegate {
    
    func membersTableViewScrolled() {
        delegate?.membersTableViewScrolled()
    }
}

