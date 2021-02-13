//
//  TypeSportPlacesController.swift
//  DoSport
//
//  Created by MAC on 19.01.2021.
//

import UIKit

final class PlaygroundListController: UIViewController {

    // MARK: - Outlets
    private lazy var menuBar: MenuBarView = {
        let menu = MenuBarView()
        menu.typeSportPlacesController = self
        menu.backgroundColor = Colors.darkBlue
        return menu
    }()
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let backBarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    private let mapFilterBarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "mapFilter").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    private let typeFilterBarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "typeFilter").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()

    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureUI()
        setupNavigationBarItems()
        navigationItem.title = "Баскетбол"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Selector Actions
    @objc private func handleBackButton(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @objc private func handleMapFilterButton(sender: UIButton) {
        print(123)
    }

    @objc private func handleTypeFilterButton(sender: UIButton) {
        print(456)
    }

    // MARK: - Helpers functions
    func scrollToMenuIndex(indexToSelect:Int) {
        let indePath = NSIndexPath(item: indexToSelect, section: 0)
        collectionView.isPagingEnabled = false // Проблемы использования на IOS 14, поэтому 2 раза
        collectionView.scrollToItem(at: indePath as IndexPath, at: UICollectionView.ScrollPosition(), animated: true)
        collectionView.isPagingEnabled = true // Проблемы использования на IOS 14, поэтому 2 раза
    }
    func pushNavigationController(indexToSelect: Int) {
        let contoller = SportGroudDescriptionController()
        navigationController?.pushViewController(contoller, animated: true)
    }
}

// MARK: - UICollectionViewDelegate
extension PlaygroundListController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalConstraint?.constant = scrollView.contentOffset.x / CGFloat(HorizontalMenuName.allCases.count)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPathToBeSelected = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPathToBeSelected, animated: false, scrollPosition: .centeredHorizontally)
    }
}

// MARK: - UICollectionViewDataSource
extension PlaygroundListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HorizontalMenuName.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaygroundListControllerCell.reuseId, for: indexPath) as! PlaygroundListControllerCell
            cell.controller.typeSportPlacesController = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeSportPlacesControllerCell.reuseId", for: indexPath)
            cell.backgroundColor = Colors.darkBlue
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeSportPlacesControllerCell.reuseId", for: indexPath)
            cell.backgroundColor = Colors.darkBlue
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PlaygroundListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - Configure UI
extension PlaygroundListController {
    private func configureUI() {
        view.backgroundColor = Colors.darkBlue
        view.addSubview(menuBar)
        view.addSubview(collectionView)

        menuBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }

        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(menuBar.snp.bottom)
            make.bottom.equalTo(view).offset(-88)
        }
    }

    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = Colors.darkBlue
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Colors.darkBlue
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PlaygroundListControllerCell.self, forCellWithReuseIdentifier: PlaygroundListControllerCell.reuseId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TypeSportPlacesControllerCell.reuseId")
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.darkBlue
        appearance.titleTextAttributes = [.foregroundColor: Colors.mainBlue]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupNavigationBarItems() {
        backBarButton.snp.makeConstraints { (make) in
            make.width.equalTo(11)
            make.height.equalTo(20)
        }
        mapFilterBarButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
        }
        typeFilterBarButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: typeFilterBarButton), UIBarButtonItem(customView: mapFilterBarButton)]

        backBarButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        mapFilterBarButton.addTarget(self, action: #selector(handleMapFilterButton), for: .touchUpInside)
        typeFilterBarButton.addTarget(self, action: #selector(handleTypeFilterButton), for: .touchUpInside)
    }
}
