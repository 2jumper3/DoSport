//
//  CollectionViewMessageCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit
import SnapKit

final class CollectionViewMessageCell: UICollectionViewCell {
    
    private(set) lazy var memberAvatarImageView: UIImageView = {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = Icons.Feed.defaultAvatar
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    private(set) var memberNameLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textColor = Colors.mainBlue
        $0.text = "Kamol"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private(set) var messageCreatedTimeLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textColor = Colors.dirtyBlue
        $0.text = "2 hours ago"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private(set) var messageLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textColor = .white
        $0.numberOfLines = 10
        $0.text = "I am in bro"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private(set) lazy var replyButton: UIButton = {
        $0.setTitle(Texts.Event.reply, for: .normal)
        $0.titleLabel?.font = Fonts.sfProRegular(size: 14)
        $0.setTitleColor(Colors.mainBlue, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubviews(
            memberAvatarImageView,
            memberNameLabel,
            messageCreatedTimeLabel,
            messageLabel,
            replyButton
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        memberAvatarImageView.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.45)
            $0.width.equalTo(memberAvatarImageView.snp.height)
        }
        
        memberNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(memberAvatarImageView.snp.right).offset(16)
            $0.height.equalTo(memberAvatarImageView.snp.height).multipliedBy(0.48)
        }
        
        messageCreatedTimeLabel.snp.makeConstraints {
            $0.top.equalTo(memberNameLabel.snp.top)
            $0.left.equalTo(memberNameLabel.snp.right).offset(8)
            $0.height.equalTo(memberNameLabel.snp.height)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(memberNameLabel.snp.bottom).offset(8)
            $0.left.equalTo(memberNameLabel.snp.left)
            $0.right.equalToSuperview().offset(-5)
        }
        
        replyButton.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(8)
            $0.left.equalTo(memberNameLabel.snp.left)
            $0.height.equalTo(memberNameLabel.snp.height)
        }
    }
}
