//
//  EventTableHeaderView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 24/02/2021.
//

import UIKit

final class EventTableHeaderView: UITableViewHeaderFooterView {
    
    var onInviteButtonClicked: (() -> Void)?
    var onParticipateButtonClicked: (() -> Void)?
    var onSegmentedControlChanged: ((Int) -> Void)?
    
    var messagesCount: Int = 0 {
        didSet {
            segmentedControl.setTitle("\(self.messagesCount) Комментариев", forItemAt: 0)
        }
    }
    
    var membersCount: Int = 0 {
        didSet {
            segmentedControl.setTitle( "\(self.membersCount) Участников", forItemAt: 1)
        }
    }
    
    //MARK: Outlets
    
    private let eventCardView = EventCardView()
    
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
    
    private lazy var segmentedControl: DSSegmentedControl = {
        let items = ["", ""]
        let segmentedControl = DSSegmentedControl(titles: items)
        segmentedControl.setSelectedItemIndex(0)
        
        let size: CGFloat = UIDevice.deviceSize == .small ? 14.5 : 16.5
            
        segmentedControl.setTitleStyle(fontSize: size)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    //MARK: Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        segmentedControl.delegate = self
        
        inviteButton.addTarget(self, action: #selector(handleInviteButton))
        participateButton.addTarget(self, action: #selector(handleParticipateButton))
        
        addSubviews(eventCardView, inviteButton, participateButton, segmentedControl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonsHeight = UIDevice.deviceSize == .small ? 40 : 48
        let segmentedControlHeight = UIDevice.deviceSize == .small ? 35 : 40
        
        eventCardView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.625)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
        }
        
        inviteButton.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.height.equalTo(buttonsHeight)
            $0.top.equalTo(eventCardView.snp.bottom).offset(16)
            $0.width.equalToSuperview().multipliedBy(0.47)
        }

        participateButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.height.equalTo(buttonsHeight)
            $0.top.equalTo(eventCardView.snp.bottom).offset(16)
            $0.width.equalToSuperview().multipliedBy(0.47)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(segmentedControlHeight)
            $0.bottom.equalTo(snp.bottom).offset(-10)
            $0.centerX.equalToSuperview()
        }
    }
}

//MARK: Public API

extension EventTableHeaderView {
    
    func getSegmentedControl() -> DSSegmentedControl {
        return segmentedControl
    }
}

//MARK: Action

@objc private extension EventTableHeaderView {
    
    func handleParticipateButton(_ button: DSEventParticipateButton) {
        button.bind()
        onParticipateButtonClicked?()
    }
    
    func handleInviteButton() {
        onInviteButtonClicked?()
    }
}

//MARK: - DSSegmentedControlDelegate -

extension EventTableHeaderView: DSSegmentedControlDelegate {
    
    func didSelectItem(at index: Int) {
        onSegmentedControlChanged?(index)
    }
}
