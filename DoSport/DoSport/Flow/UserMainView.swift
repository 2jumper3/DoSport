//
//  UserMainView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import UIKit

protocol UserMainViewDelegate: class {

}
    
final class UserMainView: UIView {
    
    weak var delegate: UserMainViewDelegate?
    
    private let tabBarHeight = UIDevice.getDeviceRelatedTabBarHeight()
    
    //MARK: Outlets
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerClass(SportGroundSelectionCollectionCell.self)
        collectionView.registerClass(UserMainInfoCollectionCell.self)
        collectionView.registerClass(EventCardCollectioCell.self)
        collectionView.registerReusableView(ReusableCollectionSegmentedView.self)
        collectionView.backgroundColor = Colors.darkBlue
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-UIDevice.getDeviceRelatedTabBarHeight()-10)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
    }
}

//MARK: Public API

extension UserMainView {
    
    func updateCollectionDataSource(dateSource: (UICollectionViewDelegate & UICollectionViewDataSource)) {
        collectionView.delegate = dateSource
        collectionView.dataSource = dateSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
}
