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
    
    init(viewModel: Event? = nil) {
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
            eventCardCell.onInviteButtonClicked = { [unowned self] in
                delegate?.tableViewInviteButtonClicked()
            }
            
            eventCardCell.onParticipateButtonClicked = { [unowned self] in
                delegate?.tableViewParicipateButtonClicked()
            }
            
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
            eventTableHeaderView.membersCount = viewModel?.members?.count ?? 0
            eventTableHeaderView.messagesCount = viewModel?.chatID?.messages?.count ?? 0
            
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
        if indexPath.section == 0 {
            var height: CGFloat = tableView.bounds.height
            
            switch UIDevice.deviceSize {  // FIXME: костыль?
            case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2: height *= 0.65
            case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini: height *= 0.57
            case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max: height *= 0.42
            default: break
            }
            
            return height
        } else {
            switch eventDataSourceState {
            case .comments: return UIDevice.deviceSize == .small ? 80 : 90
            case .members: return UIDevice.deviceSize == .small ? 45 : 50
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
            default: height = 45
            }
            
            return height
        }
        
        return 0
    }
}


