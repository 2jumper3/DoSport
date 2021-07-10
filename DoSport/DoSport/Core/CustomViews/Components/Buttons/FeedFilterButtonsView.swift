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
    private lazy var mySubscribesButton: FeedFilterButton = {
        let button = FeedFilterButton(title: Texts.Feed.subscribes, state: .notSelected)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    private lazy var mySportGroundsButton: FeedFilterButton = {
        let button = FeedFilterButton(title: Texts.Feed.mySportGrounds, state: .notSelected)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()

    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupButtonTargets()
        
        addSubviews(allButton, mySubscribesButton, mySportGroundsButton)
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
        
        mySubscribesButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.centerY.equalToSuperview()
            $0.left.equalTo(allButton.snp.right).offset(12)
        }
        
        mySportGroundsButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.centerY.equalToSuperview()
            $0.left.equalTo(mySubscribesButton.snp.right).offset(12)
        }
    }
}

//MARK: Private API

private extension FeedFilterButtonsView {
    
    func setupButtonTargets() {
        allButton.addTarget(self, action: #selector(handleAllButton))
        mySportGroundsButton.addTarget(self, action: #selector(handleSubscribersButton))
        mySubscribesButton.addTarget(self, action: #selector(handleSubscribesButton))
    }
}

//MARK: Actions

@objc private extension FeedFilterButtonsView {
    
    func handleAllButton(_ button: FeedFilterButton) {
        if button.getState() == .notSelected
            && (mySportGroundsButton.getState() == .selected
            && mySubscribesButton.getState() == .selected) {
            
            button.bind()
            mySportGroundsButton.bind(state: .notSelected)
            mySubscribesButton.bind(state: .notSelected)
        } else {
            button.bind()
        }
        
        delegate?.allButtonClicked()
    }
    
    func handleSubscribesButton(_ button: FeedFilterButton) {
        if mySportGroundsButton.getState() == .selected && allButton.getState() == .selected {
            allButton.bind()
            button.bind()
        } else {
            button.bind()
        }
        
        delegate?.subscribesButtonClicked()
    }
    
    func handleSubscribersButton(_ button: FeedFilterButton) {
        if mySubscribesButton.getState() == .selected && allButton.getState() == .selected {
            allButton.bind()
            button.bind()
        } else {
            button.bind()
        }
        
        delegate?.subscribersButtonClicked()
    }
}


