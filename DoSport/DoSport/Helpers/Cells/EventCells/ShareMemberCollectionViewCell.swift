//
//  ShareMemberCollectionViewCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/02/2021.
//

import UIKit

final class ShareMemberCollectionViewCell: UICollectionViewCell {
    
    struct ViewData {
        let name: String?
    }
    
    var avatartImage: UIImage? {
        get { memberAvatarImageView.image }
        set { memberAvatarImageView.image = newValue }
    }
    
    var memberName: String? {
        get { memberNameLabel.text }
        set { memberNameLabel.text = newValue }
    }
    
    //MARK: Outlets
    
    private lazy var memberAvatarImageView: UIImageView = {
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.image = Icons.Feed.defaultAvatar
        $0.layer.borderColor = UIColor.white.cgColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private var memberNameLabel: UILabel = {
        $0.text = "Kamol"
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = Fonts.sfProRegular(size: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = Colors.mainBlue
        
        contentView.addSubviews(memberAvatarImageView, memberNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        memberAvatarImageView.snp.makeConstraints {
            $0.top.right.left.equalToSuperview()
            $0.height.equalTo(memberAvatarImageView.snp.width)
        }
        
        memberNameLabel.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.top.equalTo(memberAvatarImageView.snp.bottom).offset(-10)
        }
    }
}

//MARK: Public API

extension ShareMemberCollectionViewCell {
    
    func bind(with data: ViewData) {
        self.memberName = data.name
    }
}
