//
//  SportGroundSelectionListView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import UIKit

final class SportGroundSelectionListView: UIView {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = UIDevice.hasBang ? 11 : 9
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerClass(SportGroundSelectionCollectionCell.self)
        collectionView.backgroundColor = Colors.darkBlue
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        addSubviews(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaInsets.top).offset(10)
            $0.bottom.equalTo(safeAreaInsets.bottom).offset(-35)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
        }
    }
}

//MARK: Public API

extension SportGroundSelectionListView {
    
    func udpateTableDataSource(dataSource: (UICollectionViewDataSource & UICollectionViewDelegate)) {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
}
