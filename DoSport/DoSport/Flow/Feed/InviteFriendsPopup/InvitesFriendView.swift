//
//  InvitesFriendView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/02/2021.
//

import UIKit

protocol InviteFriendsViewDelegate: class {
    func cancelButtonClicked()
    func searchButtonClicked()
    func shareButtonClicked()
}

final class InvitesFriendView: UIView {
    
    weak var delegate: InviteFriendsViewDelegate?
    
    //MARK: Outlets
    
    private let contentView: UIView = {
        $0.layer.cornerRadius = 12
        $0.backgroundColor = Colors.mainBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.makeAttributedText(
            with: Texts.Feed.invite,
            and: Texts.Feed.selectChat,
            text1Color: .white,
            text2Color: Colors.mainBlue
        )
        return $0
    }(UILabel())
    
    private let textInputView = DSMessageInputView()
    
    private lazy var searchButton: UIButton = {
        $0.backgroundColor = .clear
        $0.setTitleColor(.white, for: .normal)
        $0.setImage(Icons.Feed.search, for: .normal)
        $0.addTarget(self, action: #selector(handleSearchButton))
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    private lazy var shareButton: UIButton = {
        $0.backgroundColor = .clear
        $0.setTitleColor(.white, for: .normal)
        $0.setImage(Icons.Feed.share, for: .normal)
        $0.addTarget(self, action: #selector(handleShareButton))
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    private lazy var cancelButton: UIButton = {
        $0.backgroundColor = Colors.mainBlue
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle(Texts.Feed.cancel, for: .normal)
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(handleCancelButton))
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())

    
    //MARK: Init

    init() {
        super.init(frame: .zero)
        
        backgroundColor = .clear
        
        contentView.addSubviews(searchButton, titleLabel, shareButton, textInputView)
        addSubviews(contentView, cancelButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(cancelButton.snp.top).offset(-12)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.bottom.height.equalTo(48)
        }
    }
}

//MARK: Actions

@objc private extension InvitesFriendView {
    
    func handleCancelButton() {
        
    }
    
    func handleSearchButton() {
        
    }
    
    func handleShareButton() {
        
    }
}
