//
//  SportTypeGridViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class SportTypeGridViewController: UIViewController {
    
    private let goBackCompletion: (() -> Swift.Void)
    private let viewModel: SportTypeGridViewModelProtocol
    private lazy var sportTypeListView = self.view as! SportTypeGridView
    private lazy var collectionManager = SportTypeGridDataSource()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Init
    
    init(
        viewModel: SportTypeGridViewModelProtocol,
        goBackCompletion: @escaping (() -> Swift.Void)
    ) {
        self.viewModel = viewModel
        self.goBackCompletion = goBackCompletion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func loadView() {
        let view = SportTypeGridView()
        view.delegate = self
        self.collectionManager.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavBar()
        self.setupViewModelBindings()
        
        self.sportTypeListView.updateViewToState(.loading)
        self.viewModel.doLoadSportTypes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
}

//MARK: Private API

private extension SportTypeGridViewController {
    
    func setupNavBar() {
        title = Texts.SportTypeGrid.title
        guard let navController = self.navigationController as? DSNavigationController else { return }
        navController.hasSeparator(false)
    }
    
    func setupViewModelBindings() {
        viewModel.onDidLoadSportTypes = { [unowned self] state in
            if case .success = state {
                self.updateView(with: state)
            }
            
            if case .loading = state {
                self.sportTypeListView.updateViewToState(state)
            }
            
            if case .failed = state {
                // TODO: implement data fail handler view
            }
        }
        
        viewModel.onDidSaveSportTypes = { [unowned self] state in
            if case .success = state {
                self.goBackCompletion()
            }
            
            if case .loading = state {
                
            }
            
            if case .failed = state {
                
            }
        }
        
        viewModel.onDidSelectSportType = { [unowned self] in
            self.updateView(with: .success(nil))
        }
    }
    
    func updateView(with state: SportTypeGridViewModel.ViewState) {
        self.collectionManager.viewModels = viewModel.sportTypes
        self.sportTypeListView.updateViewToState(state)
        self.sportTypeListView.updateCollectionDataSource(dateSource: self.collectionManager)
    }
}

//MARK: - SportTypeGridViewDelegate -

extension SportTypeGridViewController: SportTypeGridViewDelegate {
    
    func didTapSaveButton() {
        self.viewModel.doSaveSportTypes()
    }
}

//MARK: - SportTypeListDataSourceDelegate -

extension SportTypeGridViewController: SportTypeGridDataSourceDelegate {
 
    func collectionView(didSelect sportType: SportTypeGrid.SportType) {
        self.viewModel.doSelect(sportType)
    }
}

