//
//  CollectionViewEventCardCellBodyView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit
import SnapKit

// Body part views of EventCollectioViewCell

final class CollectionViewEventCardCellBodyView: UIView {
    
    private(set) var eventShortDescriptionLabel: UILabel = { // TODO: make bold font
        $0.font = Fonts.sfProRegular(size: 16)
        $0.text = "Побросать во дворе, не хватает 3х парней Есть 2 мяча, майки с номерами разных цветов."
        $0.numberOfLines = 3
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private(set) var addressLabel: UILabel = { // TODO: add bold font to fonts
        $0.font = Fonts.sfProRegular(size: 16)
        $0.textColor = .black
        $0.text = "Oxford Circus"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private(set) var subwayImageView: UIImageView = {
        $0.image = Icons.Feed.subway
        $0.contentMode = .scaleToFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private(set) var subwayNameLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textColor = .black
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
        $0.textColor = .black
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
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        addSubviews(
            eventShortDescriptionLabel,
            addressLabel,
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        eventShortDescriptionLabel.snp.makeConstraints {
            $0.width.top.centerX.equalToSuperview()
            $0.height.equalTo(snp.height).multipliedBy(0.6)
        }
        
        addressLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(eventShortDescriptionLabel.snp.bottom).offset(12)
            $0.height.equalTo(snp.height).multipliedBy(0.2)
            $0.width.equalTo(snp.width).multipliedBy(0.7)
        }
        
        subwayImageView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalTo(addressLabel.snp.bottom).offset(6.5)
            $0.height.equalTo(addressLabel.snp.height).multipliedBy(0.7)
            $0.width.equalTo(subwayImageView.snp.height)
        }
        
        subwayNameLabel.snp.makeConstraints {
            $0.top.equalTo(subwayImageView.snp.top)
            $0.left.equalTo(subwayImageView.snp.right).offset(4)
            $0.height.equalTo(addressLabel.snp.height)
            $0.right.equalTo(addressLabel.snp.right)
        }
        
        locationLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalTo(addressLabel.snp.top)
            $0.height.equalTo(addressLabel.snp.height)
        }
        
        locationImageView.snp.makeConstraints {
            $0.right.equalTo(locationLabel.snp.left).offset(-5.5)
            $0.top.equalTo(addressLabel.snp.top)
            $0.height.equalTo(addressLabel.snp.height).multipliedBy(0.7)
            $0.width.equalTo(locationImageView.snp.height)
        }
        
        priceLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalTo(subwayNameLabel.snp.top)
            $0.height.equalTo(addressLabel.snp.height)
        }
        
        priceCurrencyImageView.snp.makeConstraints {
            $0.right.equalTo(priceLabel.snp.left).offset(-6)
            $0.top.equalTo(subwayNameLabel.snp.top)
            $0.height.equalTo(addressLabel.snp.height).multipliedBy(0.7)
            $0.width.equalTo(priceCurrencyImageView.snp.height)
        }
    }
}

