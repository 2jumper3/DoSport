//
//  TableViewCommentCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/02/2021.
//

import UIKit

final class TableViewCommentCell: UITableViewCell {
    
    var onReplyButtonClicked: ((String?) -> Void)?
    
    var avatarImage: UIImage? {
        get { memberAvatarImageView.image }
        set { memberAvatarImageView.image = newValue }
    }
    
    var memberName: String? {
        get { memberNameLabel.text }
        set { memberNameLabel.text = newValue }
    }

    var commentCreatedTime: String? {
        get { commentCreatedTimeLabel.text }
        set { commentCreatedTimeLabel.text = newValue }
    }
    
    var commentText: String? {
        get { commentTextLabel.text }
        set { commentTextLabel.text = newValue }
    }
    
    //MARK: Outlets
    
    private lazy var memberAvatarImageView: UIImageView = {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = Icons.Feed.defaultAvatar
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    private let memberNameLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textColor = Colors.mainBlue
        $0.text = "Kamol"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let commentCreatedTimeLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textColor = Colors.dirtyBlue
        $0.text = "2 hours ago"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private let commentTextLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textColor = .white
        $0.numberOfLines = 10
        $0.text = "I am in bro"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var replyButton: UIButton = {
        $0.setTitle(Texts.Event.reply, for: .normal)
        $0.titleLabel?.font = Fonts.sfProRegular(size: 14)
        $0.setTitleColor(Colors.mainBlue, for: .normal)
        $0.addTarget(self, action: #selector(handleReplyButton))
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    //MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Colors.darkBlue
        selectionStyle = .none
        contentView.addSubviews(
            memberAvatarImageView,
            memberNameLabel,
            commentCreatedTimeLabel,
            commentTextLabel,
            replyButton
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        memberAvatarImageView.image = nil
//        memberNameLabel.text = ""
//        commentCreatedTimeLabel.text = ""
//        commentTextLabel.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        
        memberAvatarImageView.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.45)
            $0.width.equalTo(memberAvatarImageView.snp.height)
        }
        
        memberNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(memberAvatarImageView.snp.right).offset(12)
            $0.height.equalTo(memberAvatarImageView.snp.height).multipliedBy(0.48)
        }
        
        commentCreatedTimeLabel.snp.makeConstraints {
            $0.top.equalTo(memberNameLabel.snp.top)
            $0.left.equalTo(memberNameLabel.snp.right).offset(8)
            $0.height.equalTo(memberNameLabel.snp.height)
        }
        
        commentTextLabel.snp.makeConstraints {
            $0.top.equalTo(memberNameLabel.snp.bottom).offset(8)
            $0.left.equalTo(memberNameLabel.snp.left)
            $0.right.equalToSuperview().offset(-5)
        }
        
        replyButton.snp.makeConstraints {
            $0.top.equalTo(commentTextLabel.snp.bottom).offset(8)
            $0.left.equalTo(memberNameLabel.snp.left)
            $0.height.equalTo(memberNameLabel.snp.height)
        }
    }
}

//MARK: Action

@objc private extension TableViewCommentCell {
    
    func handleReplyButton() {
        onReplyButtonClicked?(memberName)
    }
}
