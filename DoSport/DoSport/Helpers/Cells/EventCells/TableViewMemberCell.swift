//
//  TableViewMemberCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/02/2021.
//

import UIKit

final class TableViewMemberCell: UITableViewCell {
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Colors.darkBlue
        selectionStyle = .none
        contentView.addSubviews(
            memberAvatarImageView,
            memberNameLabel
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        memberAvatarImageView.image = nil
//        memberNameLabel.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        
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
