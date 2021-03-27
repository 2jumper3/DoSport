//
//  SportGroundSelectionListViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import UIKit

final class SportGroundSelectionListViewController: UIViewController {
    
    weak var coordinator: SportGroundSelectionListCoordinator?
    private var viewModel: SportGroundSelectionListViewModel
    private lazy var sportGroundListView = view as! SportGroundSelectionListView
    private let tableManager = SportGroundSelectionListDataSource()
    
    private let completion: (SportGround) -> Void
    
    private let sportTypeTitle: String
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(
        viewModel: SportGroundSelectionListViewModel,
        sportTypeTitle: String,
        completion: @escaping (SportGround) -> Void
    ) {
        self.viewModel = viewModel
        self.completion = completion
        self.sportTypeTitle = sportTypeTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = SportGroundSelectionListView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableManager.delegate = self
        
        setupViewModelBindings()
        setupNavBar()
        
        viewModel.prepareData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        title = nil
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.removeDependency(coordinator)
    }
}

//MARK: Actions

@objc private extension SportGroundSelectionListViewController {

    func handleMapButton() {
        print(#function)
    }
    
    func handleFilterButton() {
        print(#function)
    }
    
    func handleBackButton() {
        coordinator?.goBack()
    }
}

//MARK: Private API

private extension SportGroundSelectionListViewController {

    func setupViewModelBindings() {
        viewModel.onDidPrepareData = { [weak self] sportGrounds in
            guard let self = self else { return }
            
            self.tableManager.viewModels = sportGrounds
            self.updateView()
        }
    }
    
    func updateView() {
        sportGroundListView.udpateTableDataSource(dataSource: tableManager)
    }
    
    func setupNavBar() {
        title = sportTypeTitle
        
        /// right bar buttons setup
        let mapBtn = UIButton(type: .system), filterBtn = UIButton(type: .system)
       [mapBtn, filterBtn].forEach {
            $0.frame.size = CGSize(width: 30, height: 24)
            $0.tintColor = Colors.mainBlue
        }
        
        mapBtn.setImage(Icons.SportGroundSelectionList.map, for: .normal)
        mapBtn.addTarget(self, action: #selector(handleMapButton), for: .touchUpInside)
        filterBtn.setImage(Icons.SportGroundSelectionList.filter, for: .normal)
        filterBtn.addTarget(self, action: #selector(handleFilterButton), for: .touchUpInside)
        
        let mapBarBtn = UIBarButtonItem(customView: mapBtn), filterBarBtn = UIBarButtonItem(customView: filterBtn)
        
        navigationItem.rightBarButtonItems = [mapBarBtn, filterBarBtn]
        
        /// left back button setup
        let backBtn = DSBarBackButton()
        backBtn.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }
}

//MARK: - SportGroundSelectionListDataSourceDelegate -

extension SportGroundSelectionListViewController: SportGroundSelectionListDataSourceDelegate {
    
    func collectionView(didSelect sportGround: SportGround) {
        completion(sportGround)
        coordinator?.goBack()
    }
}
