//
//  UserMainInfoCollectionCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import UIKit

final class UserMainInfoCollectionCell: UICollectionViewCell {
    
    var onSubscribersButtonClicked: (() -> Void)?
    var onSubscribesButtonClicked: (() -> Void)?
    
    //MARK: Outlets
    
    private let avatarImageView = DSAvatartImageView(borderColor: Colors.mainBlue)
    private let subscribersCountView = DSSubscribtionCountView(name: Texts.UserMain.subscribers)
    private let subscribesCountView = DSSubscribtionCountView(name: Texts.UserMain.subscribes)
    
    //MARK: Init
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupGestures()
        
        backgroundColor = Colors.darkBlue
        
        contentView.addSubviews(avatarImageView, subscribesCountView, subscribersCountView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(4)
            $0.height.equalToSuperview().multipliedBy(0.7)
            $0.top.equalToSuperview().offset(12)
            $0.width.equalTo(avatarImageView.snp.height)
        }

        subscribesCountView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(avatarImageView.snp.top)
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
        
        subscribersCountView.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
            $0.top.equalTo(avatarImageView.snp.top)
            $0.width.equalToSuperview().multipliedBy(0.3)
        }
    }
}

//MARK: Private API

private extension UserMainInfoCollectionCell {
    
    func setupGestures() {
        let subscribesTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleSubscribesClick)
        )
        
        let subscribersTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleSubscribersClick)
        )
        
        subscribesCountView.addGestureRecognizer(subscribesTapGesture)
        subscribersCountView.addGestureRecognizer(subscribersTapGesture)
    }
}

//MARK: Action

@objc private extension UserMainInfoCollectionCell {
    
    func handleSubscribesClick() {
        onSubscribesButtonClicked?()
    }
    
    func handleSubscribersClick() {
        onSubscribersButtonClicked?()
    }
}
