//
//  SportTypeListViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

final class SportTypeListViewController: UIViewController {
    
    weak var coordinator: SportTypeListCoordinator?
    private lazy var sportTypeListView = view as! SportTypeListView
    private let tableManager = SportTypeListDataSource()
    
    private let completion: (String) -> Void
    
    private var selectedSport: Sport?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(completion: @escaping (String) -> Void) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = SportTypeListView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableManager.delegate = self
        
        prepareTableViewData()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.removeDependency(coordinator)
    }
}

//MARK: Private API

private extension SportTypeListViewController {
    
    func prepareTableViewData() {
        tableManager.viewModels = Sport.SportType.allCases.map { Sport(type: $0) }
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

//MARK: Actions

@objc private extension SportTypeListViewController {
    
    func handleBackButton() {
        coordinator?.goBack()
    }
}

//MARK: - SportTypeListDataSourceDelegate -

extension SportTypeListViewController: SportTypeListDataSourceDelegate {
    
    func tableView(didSelectSport sport: Sport) {
        sportTypeListView.bindSelectButton(state: .normal)
        self.selectedSport = sport
    }
}

//MARK: - SportTypeListViewDelegate -

extension SportTypeListViewController: SportTypeListViewDelegate {
    
    func selectButtonClicked() {
        if let selectedSport = selectedSport, let title = selectedSport.title {
            
            completion(title)
            coordinator?.goBack()
        }
    }
}




