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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch eventDataSourceState {
        case .comments: return viewModel?.chatID?.messages?.count ?? 0
        case .members: return viewModel?.members?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let eventTableHeaderView: EventTableHeaderView = tableView.dequeHeaderFooter()
        eventTableHeaderView.membersCount = viewModel?.members?.count ?? 0
        eventTableHeaderView.messagesCount = viewModel?.chatID?.messages?.count ?? 0
        
        eventTableHeaderView.onInviteButtonClicked = { [unowned self] in
            delegate?.tableViewInviteButtonClicked()
        }
        
        eventTableHeaderView.onParticipateButtonClicked = { [unowned self] in
            delegate?.tableViewParicipateButtonClicked()
        }
        
        eventTableHeaderView.onSegmentedControlChanged = { [unowned self] index in
            switch index {
            case 0: eventDataSourceState = .comments
            case 1: eventDataSourceState = .members
            default: break
            }
        }
        
        return eventTableHeaderView
    }
}

//MARK: - UITableViewDelegate -

extension EventDataSource: UITableViewDelegate  {
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch eventDataSourceState {
        case .comments: return UIDevice.deviceSize == .small ? 80 : 90
        case .members: return UIDevice.deviceSize == .small ? 45 : 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.bounds.height * 0.7
    }
}


