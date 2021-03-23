//
//  EventDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit

protocol EventDataSourceDelegate: class {
    func tableViewInviteButtonClicked()
    func tableViewParicipateButtonClicked()
//    func tableViewEventVisibilityChangeButtonClicked()
    func commentReplyButtonClicked(to userName: String?)
    func tableViewNeedsReloadData()
}

enum EventDataSourceState {
    case comments, members
}

final class EventDataSource: NSObject {
    
    var eventDataSourceState: EventDataSourceState = .comments {
        didSet {
            delegate?.tableViewNeedsReloadData()
        }
    }
    
    weak var delegate: EventDataSourceDelegate?
    
    var viewModel: Event?

    private var toogleSegmentedControl: DSSegmentedControl?
    
    private let isCurrentUserOrganisedEvent: Bool
    
    init(viewModel: Event? = nil, isCurrentUserOrganisedEvent: Bool) {
        self.isCurrentUserOrganisedEvent = isCurrentUserOrganisedEvent
        self.viewModel = viewModel
        super.init()

    }
}

//MARK: - UITableViewDataSource -

extension EventDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            switch eventDataSourceState {
            case .comments: return viewModel?.chatID?.messages?.count ?? 0
            case .members: return viewModel?.members?.count ?? 0
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if indexPath.section == 0 {
            let eventCardCell: EventCardTableCell = tableView.cell(forRowAt: indexPath)
            eventCardCell.isCurrentUserOrganisedEvent = self.isCurrentUserOrganisedEvent
            eventCardCell.onInviteButtonClicked = { [unowned self] in
                delegate?.tableViewInviteButtonClicked()
            }
            
            eventCardCell.onParticipateButtonClicked = { [unowned self] in
                delegate?.tableViewParicipateButtonClicked()
            }
            
//            eventCardCell.onEventVisibilityChangeButtonClicked = { [unowned self] in
//                delegate?.tableViewEventVisibilityChangeButtonClicked()
//            }
            cell = eventCardCell
        } else {
            switch eventDataSourceState {
            case .comments:
                let commentCell: TableViewCommentCell = tableView.cell(forRowAt: indexPath)
                commentCell.onReplyButtonClicked = { [unowned self] userName in
                    delegate?.commentReplyButtonClicked(to: userName)
                }
                
                cell = commentCell
            case .members:
                let memberCell: TableViewMemberCell = tableView.cell(forRowAt: indexPath)
                cell = memberCell
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let eventTableHeaderView: EventTableChatHeaderView = tableView.dequeHeaderFooter()
            eventTableHeaderView.firstIndexText = "\(viewModel?.members?.count ?? 0)"
            eventTableHeaderView.secondIndexText = "\(viewModel?.chatID?.messages?.count ?? 0)"
            
            eventTableHeaderView.onSegmentedControlChanged = { [unowned self] index in
                switch index {
                case 0: eventDataSourceState = .comments
                case 1: eventDataSourceState = .members
                default: break
                }
            }
            return eventTableHeaderView
        }
        
        return nil
    }
}

//MARK: - UITableViewDelegate -

extension EventDataSource: UITableViewDelegate  {
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var sectionZeroCellHeight: CGFloat = tableView.bounds.height
        var commentsCellsHeight: CGFloat = 80 // FiXME: will need to be changed to autoSizing by comment text
        var membersCellsHeight: CGFloat = 40
        
        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2:
            sectionZeroCellHeight *= 0.65
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini:
            sectionZeroCellHeight *= 0.61
            commentsCellsHeight += 5
            membersCellsHeight += 2
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max:
            sectionZeroCellHeight *= 0.5
            commentsCellsHeight += 10
            membersCellsHeight += 4
        }
        
        if indexPath.section == 0 {
            return sectionZeroCellHeight
        } else {
            switch eventDataSourceState {
            case .comments: return commentsCellsHeight
            case .members: return membersCellsHeight
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            let height: CGFloat
            
            switch UIDevice.deviceSize {  // FIXME: костыль?
            case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2: height = 50
            case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini: height = 53
            case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max: height = 55
            }
            
            return height
        }
        
        return 0
    }
}


