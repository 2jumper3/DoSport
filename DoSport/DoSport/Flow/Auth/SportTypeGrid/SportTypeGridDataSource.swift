//
//  SportTypeGridDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

protocol SportTypeGridDataSourceDelegate: class {
    func collectionView(didSelect sportType: SportTypeGrid.SportType)
}

final class SportTypeGridDataSource: NSObject {
    
    weak var delegate: SportTypeGridDataSourceDelegate?
    
    var viewModels: [SportTypeGrid.SportType]
    
    init(viewModels: [SportTypeGrid.SportType] = []) {
        self.viewModels = viewModels
        super.init()
    }
}

//MARK: - UITableViewDataSource -

extension SportTypeGridDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let viewModel: SportTypeGrid.SportType = viewModels[indexPath.row]
        
        let cell: CollectionViewSportTypeCell = collectionView.cell(forRowAt: indexPath)
        cell.text = viewModel.name
        cell.bind(isSelected: viewModel.isSelected)
        
        return cell
    }
}

//MARK: - UITableViewDelegate -

extension SportTypeGridDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]

        delegate?.collectionView(didSelect: viewModel)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout -

extension SportTypeGridDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: collectionView.bounds.width * 0.47,
            height: collectionView.bounds.height * 0.095
        )
    }
}
