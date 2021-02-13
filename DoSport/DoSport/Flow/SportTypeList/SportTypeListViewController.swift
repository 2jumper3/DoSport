//
//  SportTypeListViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

final class SportTypeListViewController: UIViewController {
    
    var coordinator: SportTypeListCoordinator?
    private(set) var viewModel: SportTypeListViewModel
    
    private lazy var sportTypeListView = view as! SportTypeListView
    
    var cell: UITableViewCell?
    private var selectedSport: Sport?
    
    private let tableManager = SportTypeListDataSource()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Init
    
    init(viewModel: SportTypeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        let view = SportTypeListView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sportTypeListView.selectButton.addTarget(self, action: #selector(handleSelectButton), for: .touchUpInside)
        
        setupTableManagerBindings()
        setupViewModelBindings()
        setupNavBar()
        
        viewModel.prepareData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: - Private methods

private extension SportTypeListViewController {

    func setupTableManagerBindings()  {
        tableManager.onDidSelectSportType = { [weak self] sport in
            self?.sportTypeListView.selectButton.bind(state: .normal)
            self?.selectedSport = sport
        }
    }
    
    func setupViewModelBindings() {
        viewModel.onDidPrepareData = { [weak self] sports in
            self?.tableManager.viewModels = sports
            self?.updateView()
        }
    }
    
    func updateView() {
        sportTypeListView.udpateTableDataSource(dataSource: tableManager)
    }
    
    func setupNavBar() {
        title = Texts.SportTypeList.navTitle
        
        let button = UIButton(type: .system)
        button.setImage(Icons.SportTypeList.backButton, for: .normal)
        button.tintColor = Colors.mainBlue
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
}

//MARK: - Actions

@objc
private extension SportTypeListViewController {
    
    func handleSelectButton() {
        if let selectedSport = selectedSport {
            
            if let cell = cell as? SelectionCell {
                cell.bind(selectedSport.title ?? "")
            }
            
            coordinator?.goBack()
        }
    }
    
    func handleBackButton() {
        coordinator?.goBack()
    }
}


