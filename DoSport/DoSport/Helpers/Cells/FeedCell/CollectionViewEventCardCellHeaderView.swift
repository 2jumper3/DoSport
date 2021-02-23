//
//  CollectionViewEventCardCellHeaderView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit
import SnapKit

// Header part views of EventCollectioViewCell

final class CollectionViewEventCardCellHeaderView: UIView {
    
    private(set) lazy var organiserImageView: UIImageView = {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = Icons.Feed.defaultAvatar
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    private(set) var organiserNameLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textColor = .black
        $0.text = "Kamol"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private(set) var eventCreatedTimeLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textColor = Colors.dirtyBlue
        $0.text = "2 hours ago"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private(set) var sportTypeLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textColor = .white
        $0.text = "Football"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private(set) lazy var optionsButton: UIButton = {
        $0.setImage(Icons.Feed.options, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        addSubviews(
            organiserImageView,
            organiserNameLabel,
            sportTypeLabel,
            eventCreatedTimeLabel,
            optionsButton
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        organiserImageView.snp.makeConstraints {
            $0.left.height.centerY.equalToSuperview()
            $0.width.equalTo(organiserImageView.snp.height)
        }
        
        organiserNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(organiserImageView.snp.right).offset(8)
            $0.height.equalTo(snp.height).multipliedBy(0.45)
        }
        
        sportTypeLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.equalTo(organiserImageView.snp.right).offset(8)
            $0.height.equalTo(snp.height).multipliedBy(0.45)
        }
        
        eventCreatedTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(organiserNameLabel.snp.right).offset(8)
            $0.height.equalTo(snp.height).multipliedBy(0.45)
        }
        
        optionsButton.snp.makeConstraints {
            $0.right.top.equalToSuperview()
            $0.height.equalTo(20)
            $0.width.equalTo(optionsButton.snp.height)
        }
    }
}

