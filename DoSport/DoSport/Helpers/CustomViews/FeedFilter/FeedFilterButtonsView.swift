//
//  FeedFilterButtonsView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/01/2021.
//

import UIKit

protocol FeedFilterButtonsViewDelegate: class {
    func allButtonClicked()
    func subscribesButtonClicked()
    func subscribersButtonClicked()
}

final class FeedFilterButtonsView: UIView {
    
    weak var delegate: FeedFilterButtonsViewDelegate?
    
    // MARK: Outlets
    
    private lazy var allButton = FeedFilterButton(title: Texts.Feed.all, state: .selected)
    private lazy var subscribesButton = FeedFilterButton(title: Texts.Feed.subscribes, state: .notSelected)
    private lazy var subscribersButton = FeedFilterButton(title: Texts.Feed.subscribers, state: .notSelected)
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupButtonTargets()
        
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

//MARK: Private API

private extension FeedFilterButtonsView {
    
    func setupButtonTargets() {
        allButton.addTarget(self, action: #selector(handleAllButton))
        subscribersButton.addTarget(self, action: #selector(handleSubscribersButton))
        subscribesButton.addTarget(self, action: #selector(handleSubscribesButton))
    }
}

//MARK: Actions

@objc private extension FeedFilterButtonsView {
    
    func handleAllButton(_ button: FeedFilterButton) {
        if button.getState() == .notSelected
            && (subscribersButton.getState() == .selected
            && subscribesButton.getState() == .selected) {
            
            button.bind()
            subscribersButton.bind(state: .notSelected)
            subscribesButton.bind(state: .notSelected)
        } else {
            button.bind()
        }
        
        delegate?.allButtonClicked()
    }
    
    func handleSubscribesButton(_ button: FeedFilterButton) {
        if subscribersButton.getState() == .selected && allButton.getState() == .selected {
            allButton.bind()
            button.bind()
        } else {
            button.bind()
        }
        
        delegate?.subscribesButtonClicked()
    }
    
    func handleSubscribersButton(_ button: FeedFilterButton) {
        if subscribesButton.getState() == .selected && allButton.getState() == .selected {
            allButton.bind()
            button.bind()
        } else {
            button.bind()
        }
        
        delegate?.subscribersButtonClicked()
    }
}


