//
//  EventTypeCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

final class EventTypeCell: UITableViewCell {
    
    private lazy var eventTypeImageView: UIImageView = {
        $0.image = Icons.EventCreate.closed
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let closedLabel: UILabel = {
        $0.textColor = .white
        $0.text = Texts.EventCreate.closed
        $0.font = Fonts.sfProRegular(size: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private(set) lazy var typeSwitch: UISwitch = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Colors.darkBlue
        $0.tintColor = Colors.dirtyBlue
        $0.onTintColor = Colors.lightBlue
        return $0
    }(UISwitch())
    
//    private let closedEventInfoLabel: UILabel = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.text = Texts.EventCreate.closedEventInfo
//        $0.textColor = Colors.dirtyBlue
//        $0.numberOfLines = 3
//        $0.font = Fonts.sfProRegular(size: 14)
//        return $0
//    }(UILabel())

    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(
            eventTypeImageView,
            closedLabel,
            typeSwitch
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        eventTypeImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(23)
            $0.height.equalToSuperview().multipliedBy(0.252)
            $0.width.equalTo(eventTypeImageView.snp.height)
        }
        
        closedLabel.snp.makeConstraints {
            $0.left.equalTo(eventTypeImageView.snp.right).offset(14)
            $0.height.equalTo(eventTypeImageView.snp.height)
        }
        
        typeSwitch.snp.makeConstraints { $0.right.equalToSuperview().offset(-15) }
        
        [eventTypeImageView, closedLabel, typeSwitch].forEach { $0.snp.makeConstraints { $0.centerY.equalToSuperview() } }
    }
}
