//
//  EventDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit

final class EventDataSource: NSObject {
    
    /// Scrolls
    var onCommentsDidScroll: ((UITableView?) -> Void)?
    var onMembersDidScroll: ((UITableView?) -> Void)?
    var onDidScroll: ((UITableView?, UITableView?) -> Void)?
    
    /// Button taps
    var onDidTapInviteButton: ((UIButton) -> Void)?
    var onDidTapParticipateButton: (() -> Void)?
    var onDidSelectSegmentedControl: ((Int, UICollectionView?) -> Void)?
    var onCommentsDidTapReplyButton: ((TableViewCommentCell) -> Void)?
    
    private lazy var eventCells: [Event.EventCellType] = [
        .eventCard(self.viewModel),
        .eventActions,
        .toogle(self.viewModel?.chatID?.messages?.count ?? 0, self.viewModel?.members?.count ?? 0),
        .activityItems([
            .messages(self.viewModel?.chatID?.messages ?? []),
            .members(self.viewModel?.members ?? [])
        ])
    ]
    
    var viewModel: Event?
    
    private let eventActivityCollectionManager = EventActivitySectionDataSource()
    private var activityCollectionView: UICollectionView?
    
    init(viewModel: Event? = nil) {
        self.viewModel = viewModel
        super.init()
        
        setupActivityCollectionManagerBindings()
    }
}

//MARK: - Actions

@objc
private extension EventDataSource {
    
    func handleInviteButton(_ button: UIButton) {
        onDidTapInviteButton?(button)
    }
    
    func handleParticipateButton(_ button: DSEventParticipateButton) {
        button.bind()
        onDidTapParticipateButton?()
    }
}

//MARK: - Private methods

private extension EventDataSource {
    
    func setupActivityCollectionManagerBindings() {
        eventActivityCollectionManager.onCommentsDidScroll = { [unowned self] commentsTableView in
            self.onCommentsDidScroll?(commentsTableView)
        }
        
        eventActivityCollectionManager.onMembersDidScroll = { [unowned self] membersTableView in
            self.onMembersDidScroll?(membersTableView)
        }
        
        eventActivityCollectionManager.onCommentsDidTapReplyButton = { [unowned self] inCell in
            self.onCommentsDidTapReplyButton?(inCell)
        }
    }
}

//MARK: - UICollectionViewDataSource

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
            
            eventActionCell.inviteButton.addTarget(
                self,
                action: #selector(handleInviteButton),
                for: .touchUpInside
            )
            
            eventActionCell.participateButton.addTarget(
                self,
                action: #selector(handleParticipateButton),
                for: .touchUpInside
            )
            
            cell = eventActionCell
            
        case .toogle(let messages, let members):
            let toogleCell: CollectionViewToogleCell = collectionView.cell(forRowAt: indexPath)
            toogleCell.segmentedControl.delegate = self
            toogleCell.messages = messages
            toogleCell.members = members
            
            cell = toogleCell
            
        case .activityItems(let activityItems):
            eventActivityCollectionManager.viewModels = activityItems
            
            let activitySectionCell: CollectionViewActivitySectionCell = collectionView.cell(forRowAt: indexPath)
            activitySectionCell.updataCollectionDataSource(dataSource: self.eventActivityCollectionManager)
            
            self.activityCollectionView = activitySectionCell.collectionView
            
            cell = activitySectionCell
        }

        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension EventDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
         if (indexPath.row == eventCells.count - 1 ) {
            print("reached last")
         }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onDidScroll?(eventActivityCollectionManager.commentsTableView, eventActivityCollectionManager.membersTableView)
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
        case .activityItems: size = CGSize(width: collectionBounds.width, height: collectionBounds.height * 0.8)
        }

        return size
    }
}

//MARK: - DSSegmentedControlDelegate

extension EventDataSource: DSSegmentedControlDelegate {
    
    func didSelectItem(at index: Int) {
        onDidSelectSegmentedControl?(index, self.activityCollectionView)
    }
}
