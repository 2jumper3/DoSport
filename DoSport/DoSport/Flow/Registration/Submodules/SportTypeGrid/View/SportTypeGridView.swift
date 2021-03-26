//
//  SportTypeGridView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

protocol SportTypeGridViewDelegate: class {
    func didTapSaveButton()
}

final class SportTypeGridView: UIView {
    
    weak var delegate: SportTypeGridViewDelegate?
    
    //MARK: Outlets
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 13
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerClass(CollectionViewSportTypeCell.self)
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
    
    private lazy var saveButton: CommonButton = {
        $0.addTarget(self, action: #selector(handleSaveButton), for:.touchUpInside)
        return $0
    }(CommonButton(title: Texts.SportTypeGrid.save, state: .normal))

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        addSubviews(collectionView, saveButton, loadingIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.top.equalTo(safeAreaInsets.top).offset(30)
            $0.height.equalToSuperview().multipliedBy(0.8)
        }
        
        saveButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.bottom.equalTo(self.safeAreaInsets.bottom).offset(-25)
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

//MARK: Public API

extension SportTypeGridView {
    
    func updateCollectionDataSource(dateSource: (UICollectionViewDataSource & UICollectionViewDelegate)) {
        collectionView.delegate = dateSource
        collectionView.dataSource = dateSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
    
    func updateViewToState(_ state: SportTypeGridDataFlow.ViewControllerState) {
        if case .success = state {
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            
            self.collectionView.isHidden = false
            self.saveButton.isHidden = false
        }
        
        if case .loading = state {
            self.loadingIndicator.isHidden = false
            self.loadingIndicator.startAnimating()
            
            self.collectionView.isHidden = true
            self.saveButton.isHidden = true
        }
        
        if case .failed = state {
            // TODO: implement data fail handler view
        }
    }
}

//MARK: Actions

@objc private extension SportTypeGridView {
    
    func handleSaveButton() {
        delegate?.didTapSaveButton()
    }
}
