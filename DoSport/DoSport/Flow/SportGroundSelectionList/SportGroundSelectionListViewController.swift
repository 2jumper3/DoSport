//
//  SportGroundSelectionListViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import UIKit

final class SportGroundSelectionListViewController: UIViewController {
    
    var coordinator: SportGroundSelectionListCoordinator?
    private var viewModel: SportGroundSelectionListViewModel
    private lazy var sportGroundListView = view as! SportGroundSelectionListView
    private let tableManager = SportGroundSelectionListDataSource()
    
    private let completion: (String) -> Void
    
    var sportTypeTitle: String = "" {
        didSet {
            title = sportTypeTitle
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Init
    
    init(viewModel: SportGroundSelectionListViewModel, completion: @escaping (String) -> Void) {
        self.viewModel = viewModel
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        let view = SportGroundSelectionListView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViewModelBindings()
        setupTableManagerBindings()
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
}

//MARK: - Actions

@objc
private extension SportGroundSelectionListViewController {

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

//MARK: - Private methods

private extension SportGroundSelectionListViewController {

    func setupTableManagerBindings()  {
//        tableManager.onDidSelectSportGroundType = { [weak self] sportGround in
//            guard let self = self, let cell = self.cell as? SelectionCell else {
//                debugPrint("############# 'self' or 'cell' is nil in SportGroundSelectionListViewController - 74 line")
//                return
//            }
//            
//            cell.bind(sportGround.title ?? "")
//            self.coordinator?.goBack()
//        }
    }
    
    func setupViewModelBindings() {
        viewModel.onDidPrepareData = { [weak self] sportGrounds in
            guard let self = self else {
                debugPrint("############# 'self' nil in SportGroundSelectionListViewController - 84 line")
                return
            }
            
            self.tableManager.viewModels = sportGrounds
            self.updateView()
        }
    }
    
    func updateView() {
        sportGroundListView.udpateTableDataSource(dataSource: tableManager)
    }
    
    func setupNavBar() {
        /// right bar buttons setup
        let mapBtn = UIButton(type: .system), filterBtn = UIButton(type: .system)
        mapBtn.setImage(Icons.SportGroundSelectionList.map, for: .normal)
        mapBtn.addTarget(self, action: #selector(handleMapButton), for: .touchUpInside)
        filterBtn.setImage(Icons.SportGroundSelectionList.filter, for: .normal)
        filterBtn.addTarget(self, action: #selector(handleFilterButton), for: .touchUpInside)
        
        let mapBarBtn = UIBarButtonItem(customView: mapBtn), filterBarBtn = UIBarButtonItem(customView: filterBtn)
        
        navigationItem.rightBarButtonItems = [mapBarBtn, filterBarBtn]
        
        /// left back button setup
        let backBtn = UIButton(type: .system)
        backBtn.setImage(Icons.SportTypeList.backButton, for: .normal)
        backBtn.tintColor = Colors.mainBlue
        backBtn.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }
}
