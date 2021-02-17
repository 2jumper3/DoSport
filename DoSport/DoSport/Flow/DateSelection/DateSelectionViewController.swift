//
//  DateSelectionViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

final class DateSelectionViewController: UIViewController {
    
    weak var coordinator: DateSelectionCoordinator?
    private(set) var viewModel: DateSelectionViewModel
    
    private lazy var dateSelectionView = view as! DateSelectionView
    
    private let collectionManager = DateSelectionDataSource()
    
    private let completion: (String) -> Void
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Init
    
    init(viewModel: DateSelectionViewModel, completion: @escaping (String) -> Void) {
        self.viewModel = viewModel
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        let view = DateSelectionView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupViewModelBindings()
        
        viewModel.prepareData()
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

//MARK: - Private methods

private extension DateSelectionViewController {

    func setupNavBar() {
        title = Texts.DateSelection.date
        
        let button = UIButton(type: .system)
        button.setImage(Icons.SportTypeList.backButton, for: .normal)
        button.tintColor = Colors.mainBlue
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func setupCollectionManageBindings() {
        collectionManager.onDidSelectHour = { hour in
            
        }
    }
    
    func setupViewModelBindings() {
        viewModel.onDidPrepareData = { [weak self] hours in
            self?.collectionManager.viewModels = hours
            self?.updateView()
        }
    }
    
    func updateView() {
        self.dateSelectionView.udpateTableDataSource(dataSource: collectionManager)
    }
}

//MARK: - Actions

@objc
private extension DateSelectionViewController {
    
    func handleBackButton() {
        coordinator?.goBack()
    }
}

