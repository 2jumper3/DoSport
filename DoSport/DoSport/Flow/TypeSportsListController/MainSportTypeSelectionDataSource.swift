//
//  MainSportTypeSelectionDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/03/2021.
//

import UIKit

protocol MainSportTypeSelectionDataSourceProtocol: class {
    
}

final class MainSportTypeSelectionDataSource: NSObject {
    
    weak var delegate: MainSportTypeSelectionDataSourceProtocol?

    var viewModels: [Sport]
    
    init(viewModels: [Sport] = []) {
        self.viewModels = viewModels
        super.init()
    }
}

//MARK: - UICollectionViewDataSource -

extension MainSportTypeSelectionDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let sportType: Sport = viewModels[indexPath.row]
        
        let cell: MainSportTypeSelectionTableCell = collectionView.cell(forRowAt: indexPath)
        cell.bind(data: .init(name: sportType.title, image: UIImage(named: sportType.icon ?? "")))
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate -

extension MainSportTypeSelectionDataSource: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDelegateFlowLayout -

extension MainSportTypeSelectionDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return .init(
            width: (UIScreen.main.bounds.width - 32 - 16) / 3,
            height: (UIScreen.main.bounds.width - 32 - 16) / 3
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 8
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 8
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}

