//
//  EventView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit

protocol EventViewDelegate: class {
    func inputViewSendButtonClicked()
}
    
final class EventView: UIView {
    
    weak var delegate: EventViewDelegate?
    
    private let tabBarHeight = UIDevice.getDeviceRelatedTabBarHeight()
    
    //MARK: Outlets

    private let messageInputTopSeparatorView = DSSeparatorView()
    
    private let messageInputView = DSMessageInputView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Colors.darkBlue
        collectionView.registerClass(CollectionViewEventCardCell.self)
        collectionView.registerClass(CollectionViewActionCell.self)
        collectionView.registerClass(CollectionViewToogleCell.self)
        collectionView.registerClass(CollectionViewChatrFrameCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        messageInputView.delegate = self
        
        addSubviews(collectionView, messageInputTopSeparatorView, messageInputView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.top.equalTo(safeAreaInsets.top).offset(22)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(messageInputView.snp.top).offset(-6)
        }
        
        messageInputTopSeparatorView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(messageInputView.snp.top).offset(-1)
        }
        
        messageInputView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.08)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(snp.bottom).offset(-tabBarHeight)
        }
    }
}

//MARK: Public API

extension EventView {
    
    func updateCollectionDataSource(dateSource: (UICollectionViewDataSource & UICollectionViewDelegate)) {
        collectionView.delegate = dateSource
        collectionView.dataSource = dateSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
    
    func getCollectionView() -> UICollectionView {
        return self.collectionView
    }
    
    func setCollectionView(isScrollingEnabled value: Bool) {
        self.collectionView.isScrollEnabled = value
    }
    
    func getInputViewText() -> String {
        return messageInputView.getInputText()
    }
    
    func setInputView(text: String) {
        messageInputView.setInput(text: text)
    }
    
    func makeInputTextViewFirstResponder() {
        messageInputView.makeTextFieldFirstResponder()
    }
    
    func removeInputTextViewFirstResponder() {
        messageInputView.removeTextFieldFirstResponder()
    }
}

//MARK: - DSTextInputViewDelegate -

extension EventView: DSTextInputViewDelegate {
    
    func sendTextButtonClicked() {
        delegate?.inputViewSendButtonClicked()
    }
}
 
