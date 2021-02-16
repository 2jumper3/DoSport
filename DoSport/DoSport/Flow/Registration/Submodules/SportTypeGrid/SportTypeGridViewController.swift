//
//  SportTypeGridViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class SportTypeGridViewController: UIViewController {
    
    var coordinator: SportTypeGridCoordinator?
    private let viewModel: SportTypeGridViewModel
    
    private lazy var sportTypeListView = self.view as! SportTypeGridView
    
    private lazy var collectionManager = SportTypeGridDataSource()
    
    private lazy var backBarButton: DSBarBackButton = {
        $0.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return $0
    }(DSBarBackButton())
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(viewModel: SportTypeGridViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = SportTypeGridView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.SportTypeGrid.title
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)
        
        setupCollectionManagerBiding()
        setupViewModelBiding()
        
        viewModel.prepareData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
}

//MARK: - Private methods

private extension SportTypeGridViewController {
    func setupCollectionManagerBiding() {
        collectionManager.onDidSelectSport = { [weak self] sport in
            self?.viewModel.handleDataSelection(sport)
        }
    }
    
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

//MARK: - SportTypeGriidtViewDelegate

extension SportTypeGridViewController: SportTypeGriidtViewDelegate {
    func didTapSaveButton() {
        viewModel.saveData() { [weak self] in
            self?.coordinator?.goToFeedModule()
        }
    }
}

//MARK: - Actions

@objc
private extension SportTypeGridViewController {
    func handleBackButton() {
        coordinator?.goBack()
    }
}
