//
//  EventDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit

protocol EventDataSourceDelegate: class {
    /// Button taps
    func collectionViewInviteButtonClicked()
    func collectionViewParicipateButtonClicked()
    func commentsTableViewReplyButtonClicked(to userName: String?)
    
    /// Segmented control index changed
    func collectionViewSegmentedControlDidChange(index: Int, collectionView: UICollectionView?)
    func chatFrameCollectionView(scrolledTo index: Int, segmentedControl: DSSegmentedControl?)
    
    /// Table & Collection views scrolls
    func commentsTableViewSrolled(tableView: UITableView?)
    func membersTableViewSrolled(tableView: UITableView?)
    func collectionViewScrolled(commentsTableView: UITableView?, membersTableView: UITableView?)
}

final class EventDataSource: NSObject {
    
    weak var delegate: EventDataSourceDelegate?
    
    private lazy var eventCells: [Event.EventCellType] = [
        .eventCard(self.viewModel),
        .eventActions,
        .toogle(self.viewModel?.chatID?.messages?.count ?? 0, self.viewModel?.members?.count ?? 0),
        .chatFrame([
            .messages(self.viewModel?.chatID?.messages ?? []),
            .members(self.viewModel?.members ?? [])
        ])
    ]
    
    var viewModel: Event?
    
    private let chatFrameCollectionManager = EventChatFrameDataSource()
    
    private lazy var commentsTableView = chatFrameCollectionManager.getCommentsTableView()
    private lazy var membersTableView = chatFrameCollectionManager.getMembersTableView()
    private var chatFrameCollectionView: UICollectionView?
    private var toogleSegmentedControl: DSSegmentedControl?
    
    init(viewModel: Event? = nil) {
        self.viewModel = viewModel
        super.init()
        
        chatFrameCollectionManager.delegate = self
    }
}

//MARK: - UICollectionViewDataSource -

extension EventDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventCells.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell
        let cellType: Event.EventCellType = eventCells[indexPath.row]

        switch cellType {
        case .eventCard(let event):
            let eventCell: CollectionViewEventCardCell = collectionView.cell(forRowAt: indexPath)
            eventCell.headerView.sportTypeLabel.text = event?.sportType?.title
            cell = eventCell
            
        case .eventActions:
            let eventActionCell: CollectionViewActionCell = collectionView.cell(forRowAt: indexPath)
            eventActionCell.onInviteButtonClicked = { [unowned self] in
                self.delegate?.collectionViewInviteButtonClicked()
            }
            
            eventActionCell.onParticipateButtonClicked = { [unowned self] in
                self.delegate?.collectionViewParicipateButtonClicked()
            }
            
            cell = eventActionCell
            
        case .toogle(let messages, let members):
            let toogleCell: CollectionViewToogleCell = collectionView.cell(forRowAt: indexPath)
            toogleCell.messages = messages
            toogleCell.members = members
            self.toogleSegmentedControl = toogleCell.getSegmentedControl()
            toogleCell.onSegmentedControlChanged = { [unowned self] index in
                delegate?.collectionViewSegmentedControlDidChange(
                    index: index,
                    collectionView: chatFrameCollectionView
                )
            }
            
            cell = toogleCell
            
        case .chatFrame(let chatFrameItems):
            chatFrameCollectionManager.viewModels = chatFrameItems
            
            let chatFrameCell: CollectionViewChatrFrameCell = collectionView.cell(forRowAt: indexPath)
            chatFrameCell.updataCollectionDataSource(dataSource: self.chatFrameCollectionManager)
            self.chatFrameCollectionView = chatFrameCell.getCollectionView()
            
            cell = chatFrameCell
        }

        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout -

extension EventDataSource: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.collectionViewScrolled(
            commentsTableView: commentsTableView,
            membersTableView: membersTableView
        )
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollView.decelerationRate = .normal
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let size: CGSize, cellType: Event.EventCellType = eventCells[indexPath.row]
        let collectionBounds = collectionView.bounds, screenBounds = UIScreen.main.bounds
        
        switch cellType {
        case .eventCard: size = CGSize(width: collectionBounds.width, height: screenBounds.height * 0.3)
        case .eventActions: size = CGSize(width: collectionBounds.width, height: screenBounds.height * 0.06)
        case .toogle: size = CGSize(width: collectionBounds.width, height: screenBounds.height * 0.05)
        case .chatFrame: size = CGSize(width: collectionBounds.width, height: collectionBounds.height * 0.8)
        }

        return size
    }
}

//MARK: - EventChatFrameDataSourceDelegate -

extension EventDataSource: EventChatFrameDataSourceDelegate {
    
    func commentsTableViewReplyButtonClicked(to userName: String?) {
        delegate?.commentsTableViewReplyButtonClicked(to: userName)
    }
    
    func commentsTableViewScrolled() {
        delegate?.commentsTableViewSrolled(tableView: commentsTableView)
    }
    
    func membersTableViewScrolled() {
        delegate?.membersTableViewSrolled(tableView: membersTableView)
    }
    
    func chatFramCollectionView(scrolledTo index: Int) {
        delegate?.chatFrameCollectionView(
            scrolledTo: index,
            segmentedControl: toogleSegmentedControl
        )
    }
}


