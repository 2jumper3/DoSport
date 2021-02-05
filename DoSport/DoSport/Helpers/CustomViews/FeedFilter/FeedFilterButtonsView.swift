//
//  FeedFilterButtonsView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/01/2021.
//

import UIKit
import SnapKit

final class FeedFilterButtonsView: UIView {
    
    private(set) lazy var allButton = FeedFilterButton(title: Texts.Feed.all, state: .selected)
    private(set) lazy var subscribesButton = FeedFilterButton(title: Texts.Feed.subscribes, state: .notSelected)
    private(set) lazy var subscribersButton = FeedFilterButton(title: Texts.Feed.subscribers, state: .notSelected)
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(allButton, subscribesButton, subscribersButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        allButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.15)
            $0.height.centerY.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        subscribesButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.height.centerY.equalToSuperview()
            $0.left.equalTo(allButton.snp.right).offset(12)
        }
        
        subscribersButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.35)
            $0.height.centerY.equalToSuperview()
            $0.left.equalTo(subscribesButton.snp.right).offset(12)
        }
    }
}
