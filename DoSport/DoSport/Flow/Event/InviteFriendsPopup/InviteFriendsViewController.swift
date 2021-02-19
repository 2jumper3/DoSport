//
//  InviteFriendsViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/02/2021.
//

import UIKit

protocol InviteFriendsViewControllerDelegate: class {
    func cancelButtonClicked()
}

final class InviteFriendsViewController: UIViewController {
    
    weak var delegate: InviteFriendsViewControllerDelegate?
    
    private let inveteFriendCollectionManager = InviteFriendsDataSource()
    private lazy var inviteFriendChildView = self.view as! InvitesFriendView
    
    //MARK: Life cycle
    
    override func loadView() {
        let view = InvitesFriendView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

//MARK: - InviteFriendsViewDelegate -

extension InviteFriendsViewController: InviteFriendsViewDelegate {
    
    func cancelButtonClicked() {
        delegate?.cancelButtonClicked()
    }
    
    func searchButtonClicked() {
        
    }
    
    func shareButtonClicked() {
        
    }
    
    func sendButtonClicked() {
        
    }
    
    func inputTextChanged(text: String?) {
        
    }
}

//MARK: - InviteFriendsDataSourceDelegate -

extension InviteFriendsViewController: InviteFriendsDataSourceDelegate {
    
    func collectionView(didSelect user: User) {
        
    }
}
