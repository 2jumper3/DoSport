//
//  DateSelectionDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

final class DateSelectionDataSource: NSObject {
    
    var onDidSelectHour: ((String) -> Void)?
    
    var viewModels: [String]
    
    private var selectedCell: CollectionViewHoursCell?
    
    init(viewModels: [String] = []) {
        self.viewModels = viewModels
        super.init()
    }
}

//MARK: - Public Methods

extension DateSelectionDataSource {
   
}

//MARK: - Actions

@objc
private extension DateSelectionDataSource {
    
}

//MARK: - UITableViewDataSource

extension DateSelectionDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let viewModel = viewModels[indexPath.row]
        
        let cell: CollectionViewHoursCell = collectionView.cell(forRowAt: indexPath)
        cell.myTitleLabel.text = viewModel
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension DateSelectionDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewHoursCell {
            self.selectedCell?.bind(state: .notSelected)
            cell.bind(state: .selected)
            self.selectedCell = cell
        }
        
        let viewModel = viewModels[indexPath.row]
        onDidSelectHour?(viewModel)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension DateSelectionDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        return CGSize(width: collectionView.frame.width * 0.31, height: collectionView.frame.height * 0.142)
    }
}
