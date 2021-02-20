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
    
    private var users: [User] = [] // test
    private var userSearchText: String = ""
    
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        inviteFriendChildView.removeMessageInputBarFirstResponder()
    }
}

//MARK: Public API

extension InviteFriendsViewController {
    
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
}

//MARK: Private API

private extension InviteFriendsViewController {
    
    func prepareCollectionData() { // test
        
        for i in 1...25 {
            let user = User(name: "\(i) - Kamol")
            users.append(user)
        }
        inveteFriendCollectionManager.viewModels = users
        inviteFriendChildView.updateCollectionDataSource(dateSource: inveteFriendCollectionManager)
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
        
        // FIXME: костыль
        let yOffset: CGFloat = keyboardFrame.height - inviteFriendChildView.getCancelButtonHeight() - 18
        
        inviteFriendChildView.makeContainerViewAnimation(
            offset: CGAffineTransform(translationX: 0, y: -yOffset)
        )
    }

    func handleKeybordWillHide() {
        inviteFriendChildView.makeContainerViewAnimation(offset: .identity)
    }
}

//MARK: - InviteFriendsViewDelegate -

extension InviteFriendsViewController: InviteFriendsViewDelegate {
    
    func cancelButtonClicked() {
        removeKeyboardNotification()
        delegate?.cancelButtonClicked()
    }
    
    func shareButtonClicked() {
        
    }
    
    func sendButtonClicked() {
        inviteFriendChildView.removeMessageInputBarFirstResponder()
//        removeKeyboardNotification()
    }
    
    func searchBarTextChanged(text: String?) {
        guard let text = text else { return }
        
        let charSet = CharacterSet(charactersIn: text.lowercased())
        
        let mappedUsers: [User] = users.compactMap {
            guard let userName = $0.name?.lowercased() else { return nil }
            
            let nameCharSet = CharacterSet(charactersIn: userName)

            if charSet.isStrictSubset(of: nameCharSet) {
                return $0
            } else {
                return nil
            }
        }
        
        inveteFriendCollectionManager.viewModels = mappedUsers
        inviteFriendChildView.updateCollectionDataSource(dateSource: inveteFriendCollectionManager)
    }
    
    func inputTextChanged(text: String?) {
        
    }
}

//MARK: - InviteFriendsDataSourceDelegate -

extension InviteFriendsViewController: InviteFriendsDataSourceDelegate {
    
    func collectionView(didSelect user: User) {
        if inviteFriendChildView.isSearhing {
            inviteFriendChildView.isSearhing = false
        }
    }
}
