//
//  SportTypeGridView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit
import SnapKit

protocol SportTypeListViewDelegate: class {
    func didTapSaveButton()
}

final class SportTypeGridView: UIView {
    
    weak var delegate: SportTypeListViewDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 13
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.registerClass(CollectionViewSportTypeCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var saveButton: CommonButton = {
        $0.addTarget(self, action: #selector(handleSaveButton), for:.touchUpInside)
        return $0
    }(CommonButton(title: Texts.SportTypeList.save, state: .normal))

    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        addSubviews(collectionView, saveButton)
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
    }
}

//MARK: - Public methods

extension SportTypeGridView {
    func updateCollectionDataSource(dateSource: (UICollectionViewDataSource & UICollectionViewDelegate)) {
        collectionView.delegate = dateSource
        collectionView.dataSource = dateSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
}

//MARK: - Actions

@objc
private extension SportTypeGridView {
    func handleSaveButton() {
        delegate?.didTapSaveButton()
    }
}
