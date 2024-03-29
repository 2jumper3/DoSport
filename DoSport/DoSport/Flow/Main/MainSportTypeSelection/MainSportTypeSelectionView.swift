//
//  MainSportTypeSelectionView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/03/2021.
//

import UIKit

protocol MainSportTypeSelectionViewDelegate: class {
    
}

final class MainSportTypeSelectionView: UIView {
    
    weak var delegate: MainSportTypeSelectionViewDelegate?
    
    // MARK: Outlets
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Виды спорта"
        label.font = Fonts.sfProRegular(size: 24)
        label.textColor = .white
        return label
    }()

    private lazy var searchBar = CustomSearchBar(frame: .zero)
    
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.registerClass(MainSportTypeSelectionTableCell.self)
        collectionView.backgroundColor = Colors.darkBlue
        return collectionView
    }()
        
    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        addSubviews(titleLabel, searchBar, collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }

        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(35)
        }
    }
}

//MARK: Public API

extension MainSportTypeSelectionView {
    
    func updateCollectionDataSource(dateSource: (UICollectionViewDataSource & UICollectionViewDelegate)) {
        collectionView.delegate = dateSource
        collectionView.dataSource = dateSource
        collectionView.reloadData()
        layoutIfNeeded()
    }
    
    func delegateSeachBar(to object: UITextFieldDelegate?) {
        searchBar.textField?.delegate = object
    }

    func bindSearchBarToStyle(main: Bool) {
        searchBar.setColorScheme(main: main)
    }
}

