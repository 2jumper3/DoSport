//
//  EventActivitySectionDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/02/2021.
//

import UIKit

final class EventActivitySectionDataSource: NSObject {
    
    var onCommentsDidScroll: ((UITableView?) -> Void)?
    var onMemberssDidScroll: ((UITableView?) -> Void)?
    
    var viewModels: [EventDataSource.EventChatCellType]
    
    private let commentsTableManager = EventCommentsDataSource()
    private let membersTableManager = EventMembersDataSource()
    
    private(set) var commentsTableView: UITableView?
    private(set) var membersTableView: UITableView?
    
    init(viewModels: [EventDataSource.EventChatCellType] = []) {
        self.viewModels = viewModels
        super.init()
        
        setupCommentsTableManagerBindings()
    }
}

//MARK: - Private methods

extension EventActivitySectionDataSource {
    
    func setupCommentsTableManagerBindings() {
        commentsTableManager.onDidScroll = { [unowned self] in
            self.onCommentsDidScroll?(self.commentsTableView)
        }
        
        membersTableManager.onDidScroll = { [unowned self] in
            self.onMemberssDidScroll?(self.membersTableView)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension EventActivitySectionDataSource: UICollectionViewDataSource {
    
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
            commentsTableView = commentCell.tableView
            commentCell.updataTAbleDataSource(dataSource: commentsTableManager)
            
            cell = commentCell
        case .members(let members):
            membersTableManager.viewModels = members
            
            let memberCell: CollectionViewMemberCell = collectionView.cell(forRowAt: indexPath)
            membersTableView = memberCell.tableView
            memberCell.updataTAbleDataSource(dataSource: membersTableManager)
            
            cell = memberCell
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension EventActivitySectionDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension EventActivitySectionDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

