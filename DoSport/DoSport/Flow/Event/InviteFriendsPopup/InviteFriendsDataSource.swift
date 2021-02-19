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

//MARK: - UITableViewDataSource -

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
//        let viewModel = viewModels[indexPath.row]
        let cell: ShareMemberCollectionViewCell = collectionView.cell(forRowAt: indexPath)
//        cell.avatartImage =
//        cell.memberName =
        return cell
    }
}

//MARK: - UITableViewDelegate -

extension InviteFriendsDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.22, height: collectionView.frame.height)
    }
}



