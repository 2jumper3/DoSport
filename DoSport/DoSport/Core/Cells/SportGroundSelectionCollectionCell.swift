//
//  SportGroundSelectionCollectionCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import UIKit

final class SportGroundSelectionCollectionCell: UICollectionViewCell {
    
    struct ViewData {
        let sportGroundTitle: String?
        let spogroundBackImage: UIImage?
        let subwayName: String?
        let location: String?
        let price: String?
    }
    
    //MARK: Outlets
    
    private let sportGroundTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.font = Fonts.sfProRegular(size: 24)
        return $0
    }(UILabel())
    
    private let backgroundImageView: UIImageView = {
        $0.image = Icons.image(named: "sampleSportGround")
        return $0
    }(UIImageView())
    
    private let gradientView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Colors.lightBlue
        $0.alpha = 0.7
        return $0
    }(UIView())
    
    private let subwayImageView: UIImageView = {
        $0.image = Icons.Feed.subway
        $0.contentMode = .scaleToFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let subwayNameLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 16)
        $0.textColor = .white
        $0.text = "Oxford Circus station"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let locationImageView: UIImageView = {
        $0.image = Icons.Feed.location
        $0.contentMode = .scaleToFill
        $0.setImageColor(color: .white)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let locationLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 16)
        $0.textColor = .white
        $0.text = Texts.Feed.km3
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let priceCurrencyImageView: UIImageView = {
        $0.image = Icons.Feed.currency
        $0.setImageColor(color: .white)
        $0.contentMode = .scaleToFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let priceLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 16)
        $0.text = Texts.Feed.free
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
            
        contentView.addSubviews(
            backgroundImageView,
            gradientView,
            sportGroundTitleLabel,
            subwayImageView,
            subwayNameLabel,
            locationImageView,
            locationLabel,
            priceCurrencyImageView,
            priceLabel
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        backgroundImageView.image = nil
//        sportGroundTitleLabel.text = ""
//        subwayNameLabel.text = ""
//        locationLabel.text = ""
//        priceLabel.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [backgroundImageView, gradientView].forEach { $0.snp.makeConstraints { $0.edges.equalTo(contentView) } }
        
        sportGroundTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY).offset(5)
            $0.left.equalToSuperview().offset(15)
            $0.height.equalTo(contentView.snp.height).multipliedBy(0.31)
        }
        
        subwayImageView.snp.makeConstraints {
            $0.left.equalTo(sportGroundTitleLabel.snp.left)
            $0.top.equalTo(sportGroundTitleLabel.snp.bottom).offset(5)
            $0.height.equalTo(subwayNameLabel.snp.height).multipliedBy(0.85)
            $0.width.equalTo(subwayImageView.snp.height)
        }
        
        subwayNameLabel.snp.makeConstraints {
            $0.top.equalTo(subwayImageView.snp.top)
            $0.left.equalTo(subwayImageView.snp.right).offset(6)
        }
        
        locationLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-12)
            $0.top.equalTo(sportGroundTitleLabel.snp.top).offset(10)
        }
        
        locationImageView.snp.makeConstraints {
            $0.right.equalTo(locationLabel.snp.left).offset(-5.5)
            $0.top.equalTo(locationLabel.snp.top)
            $0.height.equalTo(locationLabel.snp.height).multipliedBy(0.85)
            $0.width.equalTo(locationImageView.snp.height)
        }
        
        priceLabel.snp.makeConstraints {
            $0.right.equalTo(locationLabel.snp.right)
            $0.top.equalTo(subwayNameLabel.snp.top)
        }
        
        priceCurrencyImageView.snp.makeConstraints {
            $0.right.equalTo(priceLabel.snp.left).offset(-6)
            $0.top.equalTo(subwayNameLabel.snp.top)
            $0.height.equalTo(priceLabel.snp.height).multipliedBy(0.85)
            $0.width.equalTo(priceCurrencyImageView.snp.height)
        }
    }
}

//MARK: Public API

extension SportGroundSelectionCollectionCell {
    
    func bind(with data: DSModels.SportGround.SportGroundResponse) {
        sportGroundTitleLabel.text = data.title
//        backgroundImageView.image = data.spogroundBackImage
        subwayNameLabel.text = data.metroStation
        locationLabel.text = data.address
        priceLabel.text = "\(data.rentPrice ?? 12)"
    }
}

