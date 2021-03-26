//
//  SportTypeGridViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class SportTypeGridViewController: UIViewController {
    
    private let goBackCompletion: (() -> Swift.Void)
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
    
    init(
        viewModel: SportTypeGridViewModel,
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
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.SportTypeGrid.title
        
        collectionManager.delegate = self
        
        backBarButton.addTarget(self, action: #selector(handleBackButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)
        
        if case .loading = self.viewState {
            sportTypeListView.updateViewToState(self.viewState)
        }
        
        self.setupViewModelBindings()
        
        viewModel.doLoadSportTypes(request: .init())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
}

//MARK: Private API

private extension SportTypeGridViewController {
    
    func setupViewModelBindings() {
        viewModel.onDidLoadSportTypes = { [unowned self] data in
            if case .success(let viewModels) = data.state, let newViewModels = viewModels {
                self.collectionManager.viewModels = newViewModels
                self.sportTypeListView.updateViewToState(data.state)
                self.sportTypeListView.updateCollectionDataSource(dateSource: self.collectionManager)
            }
            
            if case .loading = data.state {
                self.sportTypeListView.updateViewToState(data.state)
            }
            
            if case .failed = data.state {
                // TODO: implement data fail handler view
            }
        }
        
        viewModel.onDidSaveSportTypes = { [unowned self] data in
            if case .success = data.state {
                self.goBackCompletion()
            }
            
            if case .loading = data.state {
                
            }
            
            if case .failed = data.state {
                
            }
        }
    }
    
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

