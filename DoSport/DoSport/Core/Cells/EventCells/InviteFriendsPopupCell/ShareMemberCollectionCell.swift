//
//  ShareMemberCollectionCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/02/2021.
//

import UIKit

final class ShareMemberCollectionCell: UICollectionViewCell {
    
    enum CellState {
        case selected, notSelected
    }
    
    var cellState: CellState = .notSelected {
        didSet {
            handleStateChange()
        }
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
    
    private let avatarImageViewBorderView: UIView = {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.cornerRadius = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var memberAvatarImageView: UIImageView = {
        $0.image = Icons.Feed.defaultAvatar
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private var memberNameLabel: UILabel = {
        $0.text = "Kamol"
        $0.numberOfLines = 2
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = Fonts.sfProRegular(size: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = Colors.mainBlue
        
        contentView.addSubviews(avatarImageViewBorderView, memberAvatarImageView, memberNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageViewBorderView.snp.makeConstraints {
            $0.top.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        
        memberAvatarImageView.snp.makeConstraints {
            $0.top.equalTo(avatarImageViewBorderView.snp.top).offset(8)
            $0.width.equalTo(avatarImageViewBorderView.snp.width).multipliedBy(0.8)
            $0.bottom.equalTo(avatarImageViewBorderView.snp.bottom).offset(-8)
            $0.centerX.equalTo(avatarImageViewBorderView.snp.centerX)
        }
        
        memberNameLabel.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
        }
    }
}

//MARK: Public API

extension ShareMemberCollectionCell {
    
    func bindState() {
        switch cellState {
        case .notSelected: cellState = .selected
        case .selected: cellState = .notSelected
        }
    }
    
    func bind(state: CellState) {
        cellState = state
    }
}

//MARK: Private API

private extension ShareMemberCollectionCell {
    
    func handleStateChange() {
        switch cellState {
        case .selected:
            UIViewPropertyAnimator(duration: 0.2, curve: .linear) { [unowned self] in
                avatarImageViewBorderView.backgroundColor = Colors.lightBlue
            }.startAnimation()
        case .notSelected:
            UIViewPropertyAnimator(duration: 0.2, curve: .linear) { [unowned self] in
                avatarImageViewBorderView.backgroundColor = Colors.mainBlue
            }.startAnimation()
        }
    }
}
