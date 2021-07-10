//
//  SportGroundSelectionListDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import UIKit

protocol SportGroundSelectionListDataSourceDelegate: class {
    func collectionView(didSelect sportGround: DSModels.SportGround.SportGroundResponse)
}

final class SportGroundSelectionListDataSource: NSObject {
    
    weak var delegate: SportGroundSelectionListDataSourceDelegate?
    
    var viewModels: [DSModels.SportGround.SportGroundResponse]
    
    private var selectedCell: SportTypeListTableCell?
    
    init(viewModels: [DSModels.SportGround.SportGroundResponse] = []) {
        self.viewModels = viewModels
        super.init()
        
    }
}

//MARK: - UICollectionViewDataSource -

extension SportGroundSelectionListDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: SportGroundSelectionCollectionCell = collectionView.cell(forRowAt: indexPath)
        cell.bind(with: viewModels[indexPath.row])
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate -

extension SportGroundSelectionListDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        
        delegate?.collectionView(didSelect: viewModel)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout -

extension SportGroundSelectionListDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height * 0.2)
    }
}

