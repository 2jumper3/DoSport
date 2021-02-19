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
    lazy var inviteFriendChildView = self.view as! InvitesFriendView
    
//    private var users: [User]?
    
    //MARK: Life cycle
    
    override func loadView() {
        let view = InvitesFriendView()
        view.delegate = self
        inveteFriendCollectionManager.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareCollectionData()
        setupKeyboardNotification()
    }
}

//MARK: Private API

private extension InviteFriendsViewController {
    
    func prepareCollectionData() { // test
        var users: [User] = []
        for _ in 1...10 {
            let user = User()
            users.append(user)
        }
        inveteFriendCollectionManager.viewModels = users
        inviteFriendChildView.updateCollectionDataSource(dateSource: inveteFriendCollectionManager)
    }
    
    func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeybordWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeybordWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}

//MARK: Actions

@objc private extension InviteFriendsViewController {
    
    func handleKeybordWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = (
                userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
              )?.cgRectValue
        else { return }
        
        let yOffset: CGFloat =
            keyboardFrame.height
            + inviteFriendChildView.frame.height
            - inviteFriendChildView.getCancelButtonHeight()
        
        UIView.animate(withDuration: 0.3) {
            self.inviteFriendChildView.transform = CGAffineTransform(translationX: 0, y: -yOffset)
        }
    }

    func handleKeybordWillHide() {
        UIViewPropertyAnimator(duration: 0.3, curve: .linear) { [self] in
            inviteFriendChildView.transform = .identity
        }.startAnimation()
    }
}

//MARK: - InviteFriendsViewDelegate -

extension InviteFriendsViewController: InviteFriendsViewDelegate {
    
    func cancelButtonClicked() {
        removeKeyboardNotification()
        delegate?.cancelButtonClicked()
    }
    
    func searchButtonClicked() {
        
    }
    
    func shareButtonClicked() {
        
    }
    
    func sendButtonClicked() {
        inviteFriendChildView.removeMessageInputBarFirstResponder()
        removeKeyboardNotification()
    }
    
    func inputTextChanged(text: String?) {
        
    }
}

//MARK: - InviteFriendsDataSourceDelegate -

extension InviteFriendsViewController: InviteFriendsDataSourceDelegate {
    
    func collectionView(didSelect user: User) {
        inviteFriendChildView.makeMessageInputBarFirstResponder()
    }
}
