//
//  CollectionViewActivitySectionCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/02/2021.
//

import UIKit

final class CollectionViewActivitySectionCell: UICollectionViewCell {
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Colors.darkBlue
        collectionView.registerClass(CollectionViewCommentCell.self)
        collectionView.registerClass(CollectionViewMemberCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        
        contentView.addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.snp.makeConstraints {  $0.edges.equalToSuperview() }
    }
}

//MARK: - Public methods

extension CollectionViewActivitySectionCell {
    
    func updataCollectionDataSource(dataSource: (UICollectionViewDataSource & UICollectionViewDelegate)) {
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
}

