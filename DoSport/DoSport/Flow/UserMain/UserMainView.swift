//
//  UserMainView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import UIKit
    
final class UserMainView: UIView {
    
    private let tabBarHeight = UIDevice.getDeviceRelatedTabBarHeight()// TODO: not good practice
    
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
    
    private let loadingIndicator: UIActivityIndicatorView = {
        $0.style = .white
        $0.hidesWhenStopped = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
        return $0
    }(UIActivityIndicatorView())

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        addSubviews(collectionView, loadingIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-tabBarHeight-10)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        loadingIndicator.snp.makeConstraints { $0.edges.equalToSuperview() }
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
    
    func updateViewToState<T>(_ state: UserMainDataFlow.ViewControllerState<T>) where T: Codable {
        if case .success = state {
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            
            self.collectionView.isHidden = false
        }
        
        if case .loading = state {
            self.loadingIndicator.isHidden = false
            self.loadingIndicator.startAnimating()
            
            self.collectionView.isHidden = true
        }
        
        if case .failed = state {
            // TODO: implement data fail handler view
        }
    }
}
