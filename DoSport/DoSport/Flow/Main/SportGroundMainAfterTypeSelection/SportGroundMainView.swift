//
//  SportGroundMainView.swift
//  DoSport
//
//  Created by Sergey on 05.04.2021.
//
import UIKit

final class SportGroundMainView: UIView {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = UIDevice.hasBang ? 11 : 9
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerClass(SportGroundSelectionCollectionCell.self)
        collectionView.registerClass(EventCardCollectioCell.self)
        collectionView.registerReusableView(ReusableCollectionSegmentedView.self)
        collectionView.backgroundColor = Colors.darkBlue
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    private let loadingIndicator: UIActivityIndicatorView = {
        $0.style = .medium
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
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(35)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

//MARK: Public API

extension SportGroundMainView {
    
    func updateCollectionDataSource(dataSource: (UICollectionViewDataSource & UICollectionViewDelegate)) {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
    
    func updateViewToState<T>(_ state: SportGroundDataFlow.ViewControllerState<T>) where T: Codable {
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
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
                self.collectionView.isHidden = false
            }
        }
    }
}

