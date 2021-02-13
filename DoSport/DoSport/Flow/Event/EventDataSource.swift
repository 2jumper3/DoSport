//
//  EventDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit

final class EventDataSource: NSObject {
    
    var onDidTapInviteButton: ((UIButton) -> Void)?
    var onDidTapParticipateButton: (() -> Void)?
    var onDidTapReplyButton: ((CollectionViewMessageCell) -> Void)?
    
    private enum EventCellType {
        case eventCard(Event?)
        case eventActions
        case toogle(Int, Int)
        case chatFrameItems(EventChatCellType)
    }
    
    enum EventChatCellType {
        case messages([Message]), members([Member])
    }
    
    private lazy var eventCells: [EventCellType] = [
        .eventCard(self.viewModel),
        .eventActions,
        .toogle(self.viewModel?.chatID?.messages?.count ?? 0, self.viewModel?.members?.count ?? 0),
        .chatFrameItems(self.eventChatFrameType)
    ]
    
    var eventChatFrameType: EventChatCellType = .messages([])
    
    var viewModel: Event? {
        didSet {
            guard let messages = viewModel?.chatID?.messages else {
                return
            }
//            guard let members = viewModel?.members else {
//                return
//            }
            
            eventChatFrameType = .messages(messages)
//            eventChatFrameType = .members(members)
        }
    }
    
    init(viewModel: Event? = nil) {
        self.viewModel = viewModel
        super.init()
    }
}

//MARK: - Public Methods

extension EventDataSource {
    
    func switchTo(_ type: EventChatCellType) {
        self.eventChatFrameType = type
    }
}

//MARK: - Actions

@objc
private extension EventDataSource {
    
    func handleInviteButton(_ button: UIButton) {
        onDidTapInviteButton?(button)
    }
    
    func handleParticipateButton(_ cell: CollectionViewActionCell) {
        cell.bindParticipateButton()
        onDidTapParticipateButton?()
    }
    
    func handleReplyButton(_ button: UIButton) {
        var superview = button.superview
        
        while let view = superview, !(view is CollectionViewMessageCell) {
            superview = view.superview
        }
        
        guard let cell = superview as? CollectionViewMessageCell else {
            print("button is not contained in a CollectionViewMessageCell")
            return
        }
        
        onDidTapReplyButton?(cell)
    }
}

//MARK: - UITableViewDataSource

extension EventDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count: Int
        
        switch self.eventChatFrameType {
        case .messages(let messages):
            count = messages.count + 3
        case .members(let members):
            count = members.count + 3
        }
        
        return count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell
        let cellType: EventCellType
        
        if indexPath.row < 4 {
            cellType = eventCells[indexPath.row]
        } else {
            cellType = eventCells[3]
        }

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
            
            toogleCell.messages = messages
            toogleCell.members = members
            cell = toogleCell
            
        case .chatFrameItems(let chatFrameItem):
            
            switch chatFrameItem {
            case .messages(let messages):
                let message = messages[indexPath.row - self.eventCells.count + 1]
                
                let messagesCell: CollectionViewMessageCell = collectionView.cell(forRowAt: indexPath)
                messagesCell.messageLabel.text = message.text
                messagesCell.memberNameLabel.text = message.userName
                messagesCell.replyButton.addTarget(
                    self,
                    action: #selector(handleReplyButton),
                    for: .touchUpInside
                )
                
                cell = messagesCell
                
            case .members(_):
                let membersCell: CollectionViewMemberCell = collectionView.cell(forRowAt: indexPath)
//                membersCell.memberNameLabel.text = members[indexPath.row]
                cell = membersCell
            }
        }

        return cell
    }
}

//MARK: - UITableViewDelegate

extension EventDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension EventDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let size: CGSize
        let cellType: EventCellType
        
        if indexPath.row < self.eventCells.count { // FIXME: костыль?
            cellType = eventCells[indexPath.row]
        } else {
            guard let lastCell = eventCells.last else {
                return CGSize(width: 0, height: 0)
            }
            cellType = lastCell
        }
        
        
        switch cellType {
        case .eventCard:
            size = CGSize(
                width: collectionView.bounds.width,
                height: UIScreen.main.bounds.height * 0.3
            )
            
        case .eventActions:
            size = CGSize(
                width: collectionView.bounds.width,
                height: UIScreen.main.bounds.height * 0.06
            )
            
        case .toogle:
            size = CGSize(
                width: collectionView.bounds.width,
                height: UIScreen.main.bounds.height * 0.05
            )
            
        case .chatFrameItems(let chatFrameItemsType):
            switch chatFrameItemsType {
            case .messages:
                size = CGSize(
                    width: collectionView.bounds.width,
                    height: UIScreen.main.bounds.height * 0.1
                )
                
            case .members:
                size = CGSize(
                    width: collectionView.bounds.width,
                    height: UIScreen.main.bounds.height * 0.06
                )
            }
        }

        return size
    }
}
