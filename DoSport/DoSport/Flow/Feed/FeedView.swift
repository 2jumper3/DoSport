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
    
    private let filterButtonsView = FeedFilterButtonsView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = UIDevice.hasBang ? 11 : 9
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerClass(CollectionViewEventCardCell.self)
        collectionView.backgroundColor = Colors.darkBlue
        collectionView.backgroundColor = Colors.darkBlue
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        
        addSubviews(filterButtonsView, collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var filterButtonsHeight: CGFloat = 40
        var filterButtonsWidth: CGFloat = 0.855
        
        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2:
            filterButtonsHeight = 35
            filterButtonsWidth = 0.86
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini:
            filterButtonsHeight = 40
            filterButtonsWidth = 0.855
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max:
            filterButtonsHeight = 42
            filterButtonsWidth = 0.85
        default: break
        }
        
        filterButtonsView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(filterButtonsWidth)
            $0.height.equalTo(filterButtonsHeight)
            $0.left.equalTo(collectionView.snp.left)
            $0.top.equalTo(safeAreaInsets.top).offset(16)
        }
        
        let collectionViewBottom: CGFloat = CGFloat(UIDevice.getDeviceRelatedTabBarHeight())
        collectionView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.top.equalTo(filterButtonsView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-collectionViewBottom)
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
