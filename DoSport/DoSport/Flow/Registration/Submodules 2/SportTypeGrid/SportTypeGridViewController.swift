//
//  SportTypeGridViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

protocol SportTypeGridViewControllerProtocol: class {
    func displaySportTypes(viewModel: SportTypeGridDataFlow.LoadSportTypes.ViewModel)
    func displaySaveSportTypesResult(viewModel: SportTypeGridDataFlow.SaveSelectedSportTypes.ViewModel)
}

final class SportTypeGridViewController: UIViewController {
    
    weak var coordinator: SportTypeGridCoordinator?
    private let viewModel: SportTypeGridViewModel
    private lazy var sportTypeListView = self.view as! SportTypeGridView
    private lazy var collectionManager = SportTypeGridDataSource()
    
    private var viewState: SportTypeGridDataFlow.ViewControllerState = .loading
    
    private lazy var backBarButton = DSBarBackButton()
    
    private var selectedSports: [DSModels.SportType.SportTypeView] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Init
    
    init(viewModel: SportTypeGridViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func loadView() {
        let view = SportTypeGridView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.SportTypeGrid.title
        
        collectionManager.delegate = self
        
        backBarButton.addTarget(self, action: #selector(handleBackButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)
        
        if case .loading = self.viewState {
            sportTypeListView.updateViewToLoading()
        }
        
        viewModel.doLoadSportTypes(request: .init())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.removeDependency(coordinator)
    }
}

//MARK: Private API

private extension SportTypeGridViewController {
    
    func addPreferredSportType(_ sportType: DSModels.SportType.SportTypeView) {
        guard selectedSports.count > 0 else {
            selectedSports.append(sportType)
            return
        }
        
        for (i, existedSport) in selectedSports.enumerated() {
            if existedSport == sportType {
                selectedSports.remove(at: i)
            } else {
                selectedSports.append(sportType)
            }
            return
        }
    }
}

//MARK: Actions

@objc private extension SportTypeGridViewController {
    func handleBackButton() {
        coordinator?.goBack()
    }
}

//MARK: - SportTypeGridViewControllerProtocol -

extension SportTypeGridViewController: SportTypeGridViewControllerProtocol {
    
    func displaySaveSportTypesResult(viewModel: SportTypeGridDataFlow.SaveSelectedSportTypes.ViewModel) {
        if case .success = viewModel.state {
            coordinator?.goToFeedModule()
        }
        
        if case .loading = viewModel.state {
            
        }
        
        if case .failed = viewModel.state {
            
        }
    }
    
    func displaySportTypes(viewModel: SportTypeGridDataFlow.LoadSportTypes.ViewModel) {
        if case .success(let data) = viewModel.state, let viewModels = data {
            self.collectionManager.viewModels = viewModels
            self.sportTypeListView.updateViewToSuccess()
            self.sportTypeListView.updateCollectionDataSource(dateSource: self.collectionManager)
        }
        
        if case .loading = viewModel.state {
            self.sportTypeListView.updateViewToLoading()
        }
        
        if case .failed = viewModel.state {
            
        }
    }
}

//MARK: - SportTypeGridViewDelegate -

extension SportTypeGridViewController: SportTypeGridViewDelegate {
    
    func didTapSaveButton() {
        viewModel.doSaveSportTypes(request: .init(sportTypes: selectedSports))
    }
}

//MARK: - SportTypeListDataSourceDelegate -

extension SportTypeGridViewController: SportTypeGridDataSourceDelegate {
 
    func collectionView(didSelect sport: DSModels.SportType.SportTypeView) {
        self.addPreferredSportType(sport)
    }
}

