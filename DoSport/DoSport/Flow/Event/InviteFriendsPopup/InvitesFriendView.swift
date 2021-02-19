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
    func sendButtonClicked()
    func inputTextChanged(text: String?)
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
        $0.textAlignment = .center
        $0.text = Texts.Feed.invite
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private let subTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.text = Texts.Feed.selectChat
        $0.textColor = Colors.darkBlue
        return $0
    }(UILabel())
    
    private let textInputView = DSMessageInputView(
        backgroundColor: Colors.mainBlue,
        borderColor: .white,
        textColor: .white,
        placeholderColor: .white
    )
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 18
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Colors.mainBlue
        collectionView.registerClass(ShareMemberCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    
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
        translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubviews(
            searchButton,
            titleLabel,
            subTitleLabel,
            shareButton,
            collectionView,
            textInputView
        )
        
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
        
        searchButton.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(16)
            $0.width.equalTo(23)
            $0.height.equalTo(23)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(26)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(26)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalTo(23)
            $0.height.equalTo(23)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(22)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(textInputView.snp.top).offset(-10)
        }
        
        let textInputViewHeight = UIDevice.deviceSize == .small ? 55 : 65
        textInputView.snp.makeConstraints {
            $0.height.equalTo(textInputViewHeight)
            $0.width.equalToSuperview().multipliedBy(0.95)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.bottom.height.equalTo(48)
        }
    }
}

//MARK: Public API

extension InvitesFriendView {
    
    func updateCollectionDataSource(dateSource: (UICollectionViewDataSource & UICollectionViewDelegate)) {
        collectionView.delegate = dateSource
        collectionView.dataSource = dateSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
}

//MARK: Actions

@objc private extension InvitesFriendView {
    
    func handleCancelButton() {
        delegate?.cancelButtonClicked()
    }
    
    func handleSearchButton() {
        
    }
    
    func handleShareButton() {
        
    }
}

//MARK: - DSTextInputViewDelegate -

extension InvitesFriendView: DSTextInputViewDelegate {
    
    func sendTextButtonClicked() {
        
    }
    
    func textFieldValueChaged(text: String?) {
        delegate?.inputTextChanged(text: text)
    }
}


