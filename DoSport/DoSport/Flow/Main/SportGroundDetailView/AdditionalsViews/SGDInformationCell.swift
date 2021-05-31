//
//  SGDInformationCell.swift
//  DoSport
//
//  Created by Sergey on 31.05.2021.
//

import UIKit

final class SGDInformationCell: UICollectionViewCell {
    
    struct ViewData {
        let price: String?
        let time: String?
        let sportType: String?
        let location: Int?
        let groundType: String?
        let privacy: String?
    }
    
    // MARK: - UI
    
    private let priceIcon: UIImageView = {
        $0.image = Icons.Feed.currency
        $0.setImageColor(color: .white)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private var priceLabel: UILabel = {
        $0.text = "Free"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let timeIcon: UIImageView = {
        $0.image = Icons.Feed.clock
        $0.setImageColor(color: .white)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private var timeLabel: UILabel = {
        $0.text = "10-11"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let sportTypeIcon: UIImageView = {
        $0.image = Icons.Feed.sportType
        $0.setImageColor(color: .white)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private var sportTypeLabel: UILabel = {
        $0.text = "Football"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let rangeLabel: UILabel = {
        $0.text = "3 km"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private var rangeIcon: UIImageView = {
        $0.image = Icons.Feed.location
        $0.setImageColor(color: .white)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private var groundTypeLabel: UILabel = {
        $0.text = "GroundType"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let groundTypeIcon: UIImageView = {
        $0.image = Icons.Feed.sportGround
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private var privacyLabel: UILabel = {
        $0.text = "Privacy"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let privacyIcon: UIImageView = {
        $0.image = Icons.Settings.lock
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
//
//    private let reviewLabel: UILabel = {
//        $0.text = "Отзывы"
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        return $0
//    }(UILabel())
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.backgroundColor = Colors.darkBlue.cgColor
        layer.borderWidth = 1
        layer.borderColor = Colors.dirtyBlue.cgColor
        contentView.addSubviews(priceIcon,
                                priceLabel,
                                timeIcon,
                                timeLabel,
                                sportTypeIcon,
                                sportTypeLabel,
                                rangeLabel,
                                rangeIcon,
                                groundTypeIcon,
                                groundTypeLabel,
                                privacyLabel,
                                privacyIcon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let space = Int(15)
        let leftRightOffset = 20
        let imageToLabelOffset = 12
        //left side
        priceIcon.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(25)
            $0.left.equalTo(contentView.snp.left).offset(leftRightOffset)
            $0.width.height.equalTo(18)
        }
        priceLabel.snp.makeConstraints {
            $0.top.height.equalTo(priceIcon)
            $0.left.equalTo(priceIcon.snp.right).offset(imageToLabelOffset)
            $0.right.equalTo(contentView.snp.centerY)
        }
        
        timeIcon.snp.makeConstraints {
            $0.left.right.equalTo(priceIcon)
            $0.top.equalTo(priceIcon.snp.bottom).offset(space)
            $0.height.equalTo(priceIcon.snp.height)
        }
        
        timeLabel.snp.makeConstraints {
            $0.left.right.height.equalTo(priceLabel)
            $0.top.equalTo(timeIcon.snp.top)
        }
        sportTypeIcon.snp.makeConstraints {
            $0.left.right.equalTo(priceIcon)
            $0.top.equalTo(timeLabel.snp.bottom).offset(space)
            $0.height.equalTo(priceIcon.snp.height)
        }
        sportTypeLabel.snp.makeConstraints {
            $0.left.right.height.equalTo(priceLabel)
            $0.top.equalTo(sportTypeIcon.snp.top)
        }
        //right side
        rangeLabel.snp.makeConstraints {
            $0.right.equalTo(contentView.snp.right).inset(leftRightOffset)
            $0.top.bottom.equalTo(priceLabel)
        }
        rangeIcon.snp.makeConstraints {
            $0.top.width.height.equalTo(priceIcon)
            $0.right.equalTo(rangeLabel.snp.left).offset(imageToLabelOffset)
        }
        groundTypeLabel.snp.makeConstraints {
            $0.right.height.equalTo(rangeLabel)
            $0.top.equalTo(rangeLabel.snp.bottom).offset(space)
        }
        groundTypeIcon.snp.makeConstraints {
            $0.top.width.height.equalTo(timeIcon)
            $0.right.equalTo(groundTypeLabel.snp.left).offset(imageToLabelOffset)
        }
        privacyLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(sportTypeLabel)
            $0.right.equalTo(rangeLabel)
        }
        priceIcon.snp.makeConstraints {
            $0.top.width.height.equalTo(sportTypeIcon)
            $0.right.equalTo(privacyLabel.snp.left)
        }
    }
}
