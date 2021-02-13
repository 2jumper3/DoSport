//
//  SportGroundController.swift
//  DoSport
//
//  Created by MAC on 23.01.2021.
//

import UIKit

final class PlaygroundController: UIViewController {

    // MARK: - Outlets
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Properties
    private var viewModel: PlaygroundViewModelProtocol = PlaygroundViewModel()
    var typeSportPlacesController: PlaygroundListController?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - UICollectionViewDataSource
extension PlaygroundController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.returnCountOfSportsGround()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportGroundViewCell.reuseId, for: indexPath) as! SportGroundViewCell
        cell.setupCell(sportGroundModel: viewModel.configureCell(indexPath: indexPath))
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PlaygroundController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        typeSportPlacesController?.pushNavigationController(indexToSelect: indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PlaygroundController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 110)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

// MARK: - Configure UI
extension PlaygroundController {

    private func configureUI() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        collectionView.register(SportGroundViewCell.self, forCellWithReuseIdentifier: SportGroundViewCell.reuseId)

        collectionView.backgroundColor = Colors.darkBlue
        collectionView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalTo(view)
        }
    }
}
