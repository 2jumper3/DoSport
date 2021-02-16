//
//  FeedView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

protocol FeedViewDelegate: class {
    func allFilterButtonClicked()
    func subscribesFilterButtonClicked()
    func subscribersFilterButtonClicked()
}

final class FeedView: UIView {
    
    weak var delegate: FeedViewDelegate?
    
    // MARK: Outlets
    
    private let navBarSeparatorView = DSSeparatorView()
    
    private let filterButtonsView = FeedFilterButtonsView()
    
    private let collectionView: UICollectionView = {
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
    
    //MARK: Init
    
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

//MARK: Public API

extension FeedView {
    
    func updateCollectionDataSource(dateSource: (UICollectionViewDataSource & UICollectionViewDelegate)) {
        collectionView.delegate = dateSource
        collectionView.dataSource = dateSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
}

//MARK: - FeedFilterButtonsViewDelegate -

extension FeedView: FeedFilterButtonsViewDelegate {
    
    func allButtonClicked() {
        delegate?.allFilterButtonClicked()
    }
    
    func subscribesButtonClicked() {
        delegate?.subscribesFilterButtonClicked()
    }
    
    func subscribersButtonClicked() {
        delegate?.subscribersFilterButtonClicked()
    }
}
