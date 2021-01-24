//
//  MenuBar.swift
//  DoSport
//
//  Created by MAC on 20.01.2021.
//

import UIKit

enum HorizontalMenuName: String, CaseIterable {
    case places = "Площадки"
    case trains = "Тренировки"
}

final class MenuBarView: UIView {

    // MARK: - Outlets
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private let horizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.mainBlue
        return view
    }()

    // MARK: - Properties
    var horizontalConstraint: NSLayoutConstraint?
    var typeSportPlacesController: TypeSportPlacesController?
    var numberOfItems = HorizontalMenuName.allCases.count

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame:frame)

        configureUI()
        selectedFirstIndexItem()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers functions
    private func selectedFirstIndexItem() {
        let indexpath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: indexpath as IndexPath, animated: false, scrollPosition: .centeredHorizontally)
    }
}

// MARK: - UICollectionViewDataSource
extension MenuBarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuBarViewCell.reuseId, for: indexPath) as! MenuBarViewCell
        cell.configureCell(title: HorizontalMenuName.allCases[indexPath.item].rawValue)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MenuBarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        typeSportPlacesController?.scrollToMenuIndex(indexToSelect: indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MenuBarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width / CGFloat(numberOfItems), height: frame.height)
    }
}

// MARK: - Configure UI
extension MenuBarView {
    private func configureUI() {
        backgroundColor = Colors.darkBlue
        configureCollectionView()
        configureBottomBorder()
        configureHorizontalView()
    }

    private func configureHorizontalView() {
        addSubview(horizontalView)
        horizontalConstraint = horizontalView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalConstraint?.isActive = true
        horizontalView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / CGFloat(numberOfItems)).isActive = true
        horizontalView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }

    private func configureCollectionView() {
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuBarViewCell.self, forCellWithReuseIdentifier: MenuBarViewCell.reuseId)
        collectionView.isScrollEnabled = false
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    private func configureBottomBorder() {
        addSubview(bottomBorderView)
        bottomBorderView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
