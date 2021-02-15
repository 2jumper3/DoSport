//
//  FeedView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit
import SnapKit

final class FeedView: UIView {
    
    private let navBarSeparatorView = DSSeparatorView()
    
    private(set) lazy var filterButtonsView = FeedFilterButtonsView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerClass(CollectionViewEventCardCell.self)
        collectionView.backgroundColor = Colors.darkBlue
        collectionView.layer.cornerRadius = 12
        collectionView.backgroundColor = Colors.darkBlue
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        addSubviews(
            navBarSeparatorView,
            filterButtonsView,
            collectionView
        )
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
        
        filterButtonsView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(45)
            $0.left.equalTo(collectionView.snp.left)
            $0.top.equalTo(navBarSeparatorView.snp.bottom).offset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.top.equalTo(filterButtonsView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaInsets.bottom)
        }
    }
}

//MARK: - Public Methods

extension FeedView {
    
    func updateCollectionDataSource(dateSource: (UICollectionViewDataSource & UICollectionViewDelegate)) {
        collectionView.delegate = dateSource
        collectionView.dataSource = dateSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
}
