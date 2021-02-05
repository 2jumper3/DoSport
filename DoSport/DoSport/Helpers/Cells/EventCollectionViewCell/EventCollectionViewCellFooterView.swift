//
//  EventCollectionViewCellFooterView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit
import SnapKit

// Footer part views of EventCollectioViewCell

final class EventCollectionViewCellFooterView: UIView {
    
    private(set) lazy var userImageView: UIImageView = {
        $0.image = Icons.Feed.user
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    private(set) var userCountLabel: UILabel = { // TODO: make bold font
        $0.font = Fonts.sfProRegular(size: 16)
        $0.textColor = .black
        $0.text = "10"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private(set) lazy var chatImageView: UIImageView = {
        $0.image = Icons.Feed.chat
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    private(set) var chatMessagesCountLabel: UILabel = { // TODO: make bold font
        $0.font = Fonts.sfProRegular(size: 16)
        $0.textColor = .black
        $0.text = "14"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private(set) lazy var clockImageView: UIImageView = {
        $0.image = Icons.Feed.clock
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private(set) var eventDateLabel: UILabel = { // TODO: make bold font
        $0.font = Fonts.sfProRegular(size: 16)
        $0.textColor = .white
        $0.text = "19.10.21 at 14:45"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        addSubviews(
            userImageView,
            userCountLabel,
            chatImageView,
            chatMessagesCountLabel,
            clockImageView,
            eventDateLabel
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImageView.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
            $0.width.equalTo(userImageView.snp.height)
        }
        
        userCountLabel.snp.makeConstraints {
            $0.centerY.height.equalToSuperview()
            $0.left.equalTo(userImageView.snp.right).offset(6)
        }
        
        chatImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
            $0.left.equalTo(userCountLabel.snp.right).offset(12)
            $0.width.equalTo(chatImageView.snp.height)
        }
        
        chatMessagesCountLabel.snp.makeConstraints {
            $0.centerY.height.equalToSuperview()
            $0.left.equalTo(chatImageView.snp.right).offset(4)
        }
        
        eventDateLabel.snp.makeConstraints {
            $0.right.height.centerY.equalToSuperview()
        }
        
        clockImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
            $0.right.equalTo(eventDateLabel.snp.left).offset(-9)
            $0.width.equalTo(clockImageView.snp.height)
        }
    }
}
