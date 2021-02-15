//
//  TableViewSportGroundSelectionCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import UIKit

final class TableViewSportGroundSelectionCell: UITableViewCell {
    
    private(set) var sportGroundTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.font = Fonts.sfProRegular(size: 24)
        return $0
    }(UILabel())
    
    private(set) var backgroundImageView: UIImageView = {
        $0.image = Icons.image(named: "sampleSportGround")
        return $0
    }(UIImageView())
    
    private let  gradientView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Colors.lightBlue
        $0.alpha = 0.6
        return $0
    }(UIView())
    
    private(set) var subwayImageView: UIImageView = {
        $0.image = Icons.Feed.subway
        $0.contentMode = .scaleToFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private(set) var subwayNameLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textColor = .white
        $0.text = "Oxford Circus station"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private(set) var locationImageView: UIImageView = {
        $0.image = Icons.Feed.location
        $0.contentMode = .scaleToFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private(set) var locationLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textColor = .white
        $0.text = Texts.Feed.km3
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private(set) var priceCurrencyImageView: UIImageView = {
        $0.image = Icons.Feed.currency
        $0.contentMode = .scaleToFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private(set) var priceLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 14)
        $0.text = Texts.Feed.free
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Colors.darkBlue
        selectionStyle = .none
        layer.cornerRadius = 12
        clipsToBounds = true
        
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
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        
        [backgroundImageView, gradientView].forEach { $0.snp.makeConstraints { $0.edges.equalToSuperview() } }
        
        sportGroundTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(12)
            $0.height.equalToSuperview().multipliedBy(0.31)
        }
        
        subwayImageView.snp.makeConstraints {
            $0.left.equalTo(sportGroundTitleLabel.snp.left)
            $0.top.equalTo(sportGroundTitleLabel.snp.bottom).offset(6.5)
            $0.height.equalToSuperview().multipliedBy(0.2)
            $0.width.equalTo(subwayImageView.snp.height)
        }
        
        subwayNameLabel.snp.makeConstraints {
            $0.top.equalTo(subwayImageView.snp.top)
            $0.left.equalTo(subwayImageView.snp.right).offset(6)
            $0.height.equalTo(subwayImageView.snp.height)
        }
        
        locationLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-12)
            $0.top.equalTo(sportGroundTitleLabel.snp.top)
            $0.height.equalTo(subwayNameLabel.snp.height)
        }
        
        locationImageView.snp.makeConstraints {
            $0.right.equalTo(locationLabel.snp.left).offset(-5.5)
            $0.top.equalTo(locationLabel.snp.top)
            $0.height.equalTo(subwayImageView.snp.height)
            $0.width.equalTo(locationImageView.snp.height)
        }
        
        priceLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalTo(subwayNameLabel.snp.top)
            $0.height.equalTo(locationLabel.snp.height)
        }
        
        priceCurrencyImageView.snp.makeConstraints {
            $0.right.equalTo(priceLabel.snp.left).offset(-6)
            $0.top.equalTo(subwayNameLabel.snp.top)
            $0.height.equalTo(locationImageView.snp.height)
            $0.width.equalTo(priceCurrencyImageView.snp.height)
        }
    }
}

