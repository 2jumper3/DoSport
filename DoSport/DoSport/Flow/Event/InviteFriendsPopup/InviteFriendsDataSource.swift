//
//  InviteFriendsDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/02/2021.
//

import UIKit

protocol InviteFriendsDataSourceDelegate: class {
    func collectionView(didSelect user: User)
}

final class InviteFriendsDataSource: NSObject {
    
    weak var delegate: InviteFriendsDataSourceDelegate?
    
    var viewModels: [User]
    
    init(viewModels: [User] = []) {
        self.viewModels = viewModels
        super.init()
    }
}

//MARK: - UICollectionViewDataSource -

extension InviteFriendsDataSource: UICollectionViewDataSource {
    
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
        let cell: ShareMemberCollectionViewCell = collectionView.cell(forRowAt: indexPath)
        cell.bind(with: .init(name: viewModel.name))
        return cell
    }
}

//MARK: - UICollectionViewDelegate -

extension InviteFriendsDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionView(didSelect: viewModels[indexPath.row])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout -

extension InviteFriendsDataSource: UICollectionViewDelegateFlowLayout {
    
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



