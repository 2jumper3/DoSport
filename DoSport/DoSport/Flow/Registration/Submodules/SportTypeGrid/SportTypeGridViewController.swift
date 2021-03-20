//
//  SportTypeGridViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class SportTypeGridViewController: UIViewController {
    
    weak var coordinator: SportTypeGridCoordinator?
    private let viewModel: SportTypeGridViewModel
    private lazy var sportTypeListView = self.view as! SportTypeGridView
    private lazy var collectionManager = SportTypeGridDataSource()
    
    private lazy var backBarButton = DSBarBackButton()
    
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
        
        setupViewModelBiding()
        
        viewModel.prepareData()
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
    
    func setupViewModelBiding() {
        viewModel.onDataDidPrepare = { [weak self] sports in
            self?.collectionManager.viewModels = sports
            self?.updateView()
        }
    }
    
    func updateView() {
        self.sportTypeListView.updateCollectionDataSource(dateSource: self.collectionManager)
    }
}

//MARK: Actions

@objc private extension SportTypeGridViewController {
    func handleBackButton() {
        coordinator?.goBack()
    }
}

//MARK: - SportTypeGridViewDelegate -

extension SportTypeGridViewController: SportTypeGridViewDelegate {
    
    func didTapSaveButton() {
        viewModel.saveData() { [weak self] in
            self?.coordinator?.goToFeedModule()
        }
    }
}

//MARK: - SportTypeListDataSourceDelegate -

extension SportTypeGridViewController: SportTypeGridDataSourceDelegate {
 
    func collectionView(didSelect sport: DSModels.Api.SportType.SportTypeResponse) {
        viewModel.handleDataSelection(sport)
    }
}


