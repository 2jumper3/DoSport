//
//  CollectionViewActionCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit

final class CollectionViewActionCell: UICollectionViewCell {
    
    var onInviteButtonClicked: (() -> Void)?
    var onParticipateButtonClicked: (() -> Void)?
    
    //MARK: Outlets
    
    private lazy var inviteButton: UIButton = {
        $0.setTitle(Texts.Event.invite, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.font = Fonts.sfProRegular(size: 18)
        return $0
    }(UIButton(type: .system))
    
    private lazy var participateButton = DSEventParticipateButton(state: .notSeleted)
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        
        inviteButton.addTarget(self, action: #selector(handleInviteButton))
        participateButton.addTarget(self, action: #selector(handleParticipateButton))
        
        contentView.addSubviews(inviteButton, participateButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        inviteButton.snp.makeConstraints {
            $0.left.height.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.48)
        }

        participateButton.snp.makeConstraints {
            $0.right.height.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.48)
        }
    }
}

//MARK: Action

@objc private extension CollectionViewActionCell {
    
    func handleParticipateButton(_ button: DSEventParticipateButton) {
        button.bind()
        onParticipateButtonClicked?()
    }
    
    func handleInviteButton() {
        onInviteButtonClicked?()
    }
}

