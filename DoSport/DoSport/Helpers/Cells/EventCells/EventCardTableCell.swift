//
//  EventCardTableCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import UIKit

final class EventCardTableCell: UITableViewCell {
    
    var onInviteButtonClicked: (() -> Void)?
    var onParticipateButtonClicked: (() -> Void)?
    
    //MARK: Outlets
    
    private let eventCardView = DSEventCardView()
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        inviteButton.addTarget(self, action: #selector(handleInviteButton))
        participateButton.addTarget(self, action: #selector(handleParticipateButton))
        
        backgroundColor = Colors.darkBlue
        selectionStyle = .none
        
        contentView.addSubviews(eventCardView, inviteButton, participateButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var buttonsHeight: CGFloat
        
        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2: buttonsHeight = 42
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini: buttonsHeight = 45
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max: buttonsHeight = 47
        default: buttonsHeight = 42
        }
        
        eventCardView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.74)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
        }
        
        inviteButton.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.height.equalTo(buttonsHeight)
            $0.bottom.equalToSuperview().offset(-5)
            $0.width.equalToSuperview().multipliedBy(0.47)
        }

        participateButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.height.equalTo(buttonsHeight)
            $0.bottom.equalToSuperview().offset(-5)
            $0.width.equalToSuperview().multipliedBy(0.47)
        }
    }
}

//MARK: Action

@objc private extension EventCardTableCell {
    
    func handleParticipateButton(_ button: DSEventParticipateButton) {
        button.bind()
        onParticipateButtonClicked?()
    }
    
    func handleInviteButton() {
        onInviteButtonClicked?()
    }
}
