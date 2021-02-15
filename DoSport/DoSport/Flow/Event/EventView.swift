//
//  EventView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit
import SnapKit

final class EventView: UIView {
    
    private let navBarSeparatorView = DSSeparatorView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.registerClass(CollectionViewEventCardCell.self)
        collectionView.registerClass(CollectionViewActionCell.self)
        collectionView.registerClass(CollectionViewToogleCell.self)
        collectionView.registerClass(CollectionViewMessageCell.self)
        collectionView.registerClass(CollectionViewMemberCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var messageInputView = DSMessageInputView()

    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        addSubviews(navBarSeparatorView, collectionView, messageInputView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        navBarSeparatorView.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(self.safeAreaInsets.top).offset(10)
        }
        
        collectionView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.top.equalTo(safeAreaInsets.top).offset(26)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(messageInputView.snp.top).offset(-6)
        }
        
        messageInputView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.08)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaInsets.bottom).offset(-16)
        }
    }
}

//MARK: - Public Methods

extension EventView {
    
    func updateCollectionDataSource(dateSource: (UICollectionViewDataSource & UICollectionViewDelegate)) {
        collectionView.delegate = dateSource
        collectionView.dataSource = dateSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
}