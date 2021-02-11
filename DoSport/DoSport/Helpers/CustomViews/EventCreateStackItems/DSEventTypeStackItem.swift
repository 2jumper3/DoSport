//
//  DSEventTypeStackItem.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit
import SnapKit

final class DSEventTypeStackItem: UIView {
    
    private let topSeperatorView = DSSeparatorView()
    
    private lazy var eventTypeImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = Icons.EventCreate.closed
        return $0
    }(UIImageView())
    
    private let closedLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = Texts.EventCreate.closed
        $0.textColor = .white
        $0.font = Fonts.sfProRegular(size: 18)
        return $0
    }(UILabel())
    
    private(set) lazy var typeSwitch: UISwitch = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UISwitch())
    
    private let bottomSeperatorView = DSSeparatorView()
    
    private let closedEventInfoLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = Texts.EventCreate.closedEventInfo
        $0.textColor = Colors.dirtyBlue
        $0.numberOfLines = 3
        $0.font = Fonts.sfProRegular(size: 14)
        return $0
    }(UILabel())

    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
     
        addSubviews(
            topSeperatorView,
            eventTypeImageView,
            closedLabel,
            typeSwitch,
            bottomSeperatorView,
            closedEventInfoLabel
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        topSeperatorView.snp.makeConstraints {
            $0.top.width.centerX.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        eventTypeImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview().offset(23)
            $0.height.equalToSuperview().multipliedBy(0.252)
            $0.width.equalTo(eventTypeImageView.snp.height)
        }
        
        closedLabel.snp.makeConstraints {
            $0.top.equalTo(eventTypeImageView.snp.top)
            $0.left.equalTo(eventTypeImageView.snp.right).offset(14)
            $0.height.equalTo(eventTypeImageView.snp.height)
        }
        
        typeSwitch.snp.makeConstraints {
            $0.centerY.equalTo(eventTypeImageView.snp.centerY)
            $0.right.equalToSuperview().offset(-15)
        }
        
        bottomSeperatorView.snp.makeConstraints {
            $0.top.equalTo(eventTypeImageView.snp.bottom).offset(18)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        closedEventInfoLabel.snp.makeConstraints {
            $0.top.equalTo(bottomSeperatorView.snp.bottom).offset(2)
            $0.left.equalTo(eventTypeImageView.snp.left)
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.width.equalToSuperview().multipliedBy(0.914)
        }
    }
}
