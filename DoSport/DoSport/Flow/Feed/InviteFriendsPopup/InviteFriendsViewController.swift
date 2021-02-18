//
//  InviteFriendsViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/02/2021.
//

import UIKit

final class InviteFriendsViewController: UIViewController {
    
    enum ChildViewControllerState {
        case expanded, collapsed
    }
    
    private var isChildViewControllerExpanded = false
    
    private var nextState: ChildViewControllerState {
        return isChildViewControllerExpanded ? .collapsed : .expanded
    }
    
    private var inviteFriendChildViewController: InviteFriendsViewController!
    private lazy var childViewControllerHeight: CGFloat = self.view.bounds.height * 0.4
    
    private lazy var inviteFriendChildView = self.view as! InvitesFriendView
    
    //MARK: Life cycle
    
    override func loadView() {
        let view = InvitesFriendView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
