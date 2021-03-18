//
//  FeedDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

protocol FeedDataSourceDelegate: class {
    func collectionView(didSelect event: Event)
}

final class FeedDataSource: NSObject {
    
    weak var delegate: FeedDataSourceDelegate?

    var viewModels: [Event]
    
    init(viewModels: [Event] = []) {
        self.viewModels = viewModels
        super.init()
    }
}

//MARK: - UITableViewDataSource -

extension FeedDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: EventCardCollectioCell = collectionView.cell(forRowAt: indexPath)

        let viewModel = viewModels[indexPath.row]
        cell.footerView.chatMessagesCountLabel.text = String(describing: viewModel.chatID?.messages?.count ?? 0)
        cell.footerView.userCountLabel.text = String(describing: viewModel.members?.count ?? 0)
        
        return cell
    }
}

//MARK: - UITableViewDelegate -

extension FeedDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        
//        guard let cell: EventCollectionViewCell = collectionView.cellForItem(at: indexPath) as? EventCollectionViewCell
//        else { return }
        
//        cell.bind()
        delegate?.collectionView(didSelect: viewModel)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout -

extension FeedDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        var height: CGFloat = UIScreen.main.bounds.height
        
        switch UIDevice.deviceSize {
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2: height *= 0.3
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini: height *= 0.28
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max: height *= 0.26
        }
        
        return CGSize(width: collectionView.bounds.width, height: height)
    }
}

