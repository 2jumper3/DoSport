//
//  EventView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit
import SnapKit

final class EventView: UIView {
    
    private let navBarSeparatorView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Colors.dirtyBlue
        return $0
    }(UIView())
    
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
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        addSubviews(navBarSeparatorView, collectionView)
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
