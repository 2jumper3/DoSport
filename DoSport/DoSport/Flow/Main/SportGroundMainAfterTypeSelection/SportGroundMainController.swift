//
//  SportGroundMainController.swift
//  DoSport
//
//  Created by Sergey on 05.04.2021.
//
import UIKit

final class SportGroundMainController: UIViewController {
    
    weak var coordinator: SportGroundMainCoordinator?
    private var viewModel: SportGroundMainViewModel
    private lazy var sportGroundListView = view as! SportGroundMainView
    private let tableManager = SportGroundMainDataSource()
    
    private let sportTypeTitle: String
    private var viewState: SportGroundDataFlow.ViewControllerState<DSEmptyRequest> = .loading
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(
        viewModel: SportGroundMainViewModel,
        sportTypeTitle: String
    ) {
        self.viewModel = viewModel
        self.sportTypeTitle = sportTypeTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = SportGroundMainView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableManager.delegate = self
        setupViewModelBindings()
        setupNavBar()
        print(self.sportTypeTitle)
        if case .loading = self.viewState {
            sportGroundListView.updateViewToState(self.viewState)
        }
        self.viewModel.doLoadSportGrounds(request: .init())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
        title = nil
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.removeDependency(coordinator)
    }
}

//MARK: Actions

@objc private extension SportGroundMainController {

    func handleMapButton() {
        coordinator?.goToMap()
    }
    
    func handleFilterButton() {
        print(#function)
    }
    
    func handleBackButton() {
        coordinator?.goBack()
    }
}

//MARK: Private API

private extension SportGroundMainController {

    func setupViewModelBindings() {
        viewModel.didLoadSportGrounds = { [weak self] sportGrounds in
            self?.updateState(sportGrounds.state)
        }
        viewModel.onDidPrepareData = { [weak self] sportGrounds in
            guard let self = self else { return }

            self.tableManager.viewModels = sportGrounds
            self.updateView()
        }
    }
    func updateState<T>(_ state: SportGroundDataFlow.ViewControllerState<T>) where T: Codable {
        switch state {
        case .loading:
            self.sportGroundListView.updateViewToState(state)
        case .failed:
            self.sportGroundListView.updateViewToState(state)
        case .success(let data):
            if let viewModels = data as? [DSModels.SportGround.SportGroundResponse] {
                self.tableManager.viewModels = viewModels
            }
            self.sportGroundListView.updateCollectionDataSource(dataSource: tableManager)
            self.sportGroundListView.updateViewToState(state)
        }
    }
    
    func updateView() {
        sportGroundListView.updateCollectionDataSource(dataSource: tableManager)
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
        let backBtn = UIButton.makeBarButton()
        backBtn.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }
}

//MARK: - SportGroundSelectionListDataSourceDelegate -

extension SportGroundMainController: SportGroundMainDataSourceDelegate {
    func collectionViewEvent(didSelect event: DSModels.Event.EventView) {
//        coordinator.go
    }
    
    func collectionView(didSelect sportGround: DSModels.SportGround.SportGroundResponse) {
        coordinator?.goToSportGround(sportGround: sportGround)
    }
    
    func collectionViewNeedsReloadData() {
        sportGroundListView.updateCollectionDataSource(dataSource: tableManager)
    }
}
