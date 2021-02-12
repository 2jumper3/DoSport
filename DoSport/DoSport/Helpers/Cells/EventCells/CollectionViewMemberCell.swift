//
//  CollectionViewMemberCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit
import SnapKit

final class CollectionViewMemberCell: UICollectionViewCell {
    
    private(set) lazy var memberAvatarImageView: UIImageView = {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = Icons.Feed.defaultAvatar
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private(set) var memberNameLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textColor = .white
        $0.text = "Kamol"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubviews(
            memberAvatarImageView,
            memberNameLabel
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        memberAvatarImageView.snp.makeConstraints {
            $0.left.centerY.height.equalToSuperview()
            $0.width.equalTo(memberAvatarImageView.snp.height)
        }
        
        memberNameLabel.snp.makeConstraints {
            $0.height.centerY.equalToSuperview()
            $0.left.equalTo(memberAvatarImageView.snp.right).offset(16)
        }
    }
}
