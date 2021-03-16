//
//  EventInviteDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/02/2021.
//

import UIKit

protocol EventInviteDataSourceDelegate: class {
    func collectionView(didSelect user: User, with key: Int)
    func collectionView(didUnselect user: User, for key: Int)
}

final class EventInviteDataSource: NSObject {
    
    weak var delegate: EventInviteDataSourceDelegate?
    
    var viewModels: [User]
    var selectedIndecies: [Int: User] = [:]
    
    init(viewModels: [User] = []) {
        self.viewModels = viewModels
        super.init()
    }
}

//MARK: - UICollectionViewDataSource -

extension EventInviteDataSource: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let viewModel = viewModels[indexPath.row]
        
        let cell: ShareMemberCollectionCell = collectionView.cell(forRowAt: indexPath)
        cell.bind(with: .init(name: viewModel.name))
        cell.bind(state: .notSelected)
        
        if selectedIndecies.values.contains(viewModel) {
            cell.bind(state: .selected)
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate -

extension EventInviteDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = viewModels[indexPath.row]

        if selectedIndecies.values.contains(user) {
            selectedIndecies.removeValue(forKey: indexPath.row)
            delegate?.collectionView(didUnselect: user, for: indexPath.row)
        } else {
            selectedIndecies[indexPath.row] = user
            delegate?.collectionView(didSelect: user, with: indexPath.row)
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ShareMemberCollectionCell else { return }
        cell.bindState()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout -

extension EventInviteDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: collectionView.bounds.width * 0.20,
            height: collectionView.bounds.width / 4 + 15
        )
    }
}



