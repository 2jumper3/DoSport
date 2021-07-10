//
//  EventCardCollectioCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/01/2021.
//

import UIKit

final class EventCardCollectioCell: UICollectionViewCell {
    
    var onOptionButtonClicked: (() -> Swift.Void)?
    
    private(set) lazy var headerView = CollectionViewEventCardCellHeaderView()
    private(set) lazy var bodyView = CollectionViewEventCardCellBodyView()
    private(set) lazy var footerView = CollectionViewEventCardCellFooterView()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = Colors.mainBlue
        layer.cornerRadius = 12
        
        headerView.optionsButton.addTarget(self, action: #selector(handleOptionsButton))
        
        contentView.addSubviews(
            headerView,
            bodyView,
            footerView
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(14)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(snp.height).multipliedBy(0.164)
        }
        
        bodyView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom).offset(14)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(snp.height).multipliedBy(0.43)
        }
        
        footerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(snp.bottom).offset(-8)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(snp.height).multipliedBy(0.11)
        }
    }
    //MARK: - Bind

    func bind(data: DSModels.Event.EventView) {
        headerView.eventCreatedTimeLabel.text = data.creationDateTime
        headerView.organiserNameLabel.text = data.organizer?.username
        headerView.sportTypeLabel.text = data.sportType
        
        bodyView.addressLabel.text = "\(data.sportGroundID ?? 0)"
        bodyView.eventShortDescriptionLabel.text = data.description
        if data.price == 0 {
            let free = Texts.Feed.free
            bodyView.priceLabel.text = free
        } else {
            bodyView.priceLabel.text = "\(data.price ?? 0)"
        }
//        bodyView.subwayNameLabel.text = data.
        
        footerView.eventDateLabel.text = data.startDateTime
    }
}

//MARK: Actions

@objc private extension EventCardCollectioCell {
    
    func handleOptionsButton() {
        onOptionButtonClicked?()
    }



}
