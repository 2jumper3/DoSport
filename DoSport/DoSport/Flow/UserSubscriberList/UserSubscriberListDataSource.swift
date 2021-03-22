//
//  UserSubscriberListDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import UIKit

protocol UserSubscriberListDataSourceDelegate: class {
    func collectionViewNeedsReloadData()
    func collectionView(didSelect user: User?)
}

enum UserSubscriberListDataSourceState {
    case subscribes, subscribers
}

final class UserSubscriberListDataSource: NSObject {
    
    weak var delegate: UserSubscriberListDataSourceDelegate?
    
    var userSubscriberListDataSourceState: UserSubscriberListDataSourceState = .subscribes {
        didSet {
            delegate?.collectionViewNeedsReloadData()
        }
    }
    
    var subscribes: [User]?
    var subscribers: [User]?
    
    private var toogleSegmentedControl: DSSegmentedControl?
    
    init(viewModels: [User]? = []) {
        self.subscribes = viewModels
        super.init()

    }
}

//MARK: Public API

extension UserSubscriberListDataSource {
    
    func updateSegmentedControl(index: Int) {
        toogleSegmentedControl?.setSelectedItemIndex(index)
    }
}

//MARK: - UITableViewDataSource -

extension UserSubscriberListDataSource:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch userSubscriberListDataSourceState {
        case .subscribes: return  14
        case .subscribers: return  5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
//        let subscribe = subscribes?[indexPath.row]
//        let subscriber = subscribers?[indexPath.row]
        
        switch userSubscriberListDataSourceState {
        case .subscribes:
            let subscribeCell: TableViewMemberCell = tableView.cell(forRowAt: indexPath)
//            subscribeCell.memberNameLabel.text = subscribe?.name
       
            cell = subscribeCell
        case .subscribers:
            let subscriberCell: TableViewMemberCell = tableView.cell(forRowAt: indexPath)
//            subscriberCell.memberNameLabel.text = subscriber?.name
       
            cell = subscriberCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let eventTableHeaderView: EventTableChatHeaderView = tableView.dequeHeaderFooter()
        eventTableHeaderView.firstIndexText = /* subscribes?.count ??*/ "\(14) Подписки"
        eventTableHeaderView.secondIndexText = /* subscribers?.count ??*/ "\(5) Подписчики"
        self.toogleSegmentedControl = eventTableHeaderView.getSegmentedControl()
        
        eventTableHeaderView.onSegmentedControlChanged = { [unowned self] index in
            switch index {
            case 0: userSubscriberListDataSourceState = .subscribes
            case 1: userSubscriberListDataSourceState = .subscribers
            default: break
            }
        }
        
        return eventTableHeaderView
    }
}

//MARK: - UITableViewDelegate -

extension UserSubscriberListDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user: User? = .init(id: 1, name: "Lincoln")
        
//        switch userSubscriberListDataSourceState {
//        case .subscribers: user = subscribers?[indexPath.row]
//        case .subscribes: user = subscribes?[indexPath.row]
//        }
        
        delegate?.collectionView(didSelect: user)

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var membersCellsHeight: CGFloat = 40
        
        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2:
            break
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini:
            membersCellsHeight += 2
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max:
            membersCellsHeight += 4
        }
        
       return membersCellsHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat
        
        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2: height = 50
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini: height = 53
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max: height = 55
        }
        
        return height
    }
}
