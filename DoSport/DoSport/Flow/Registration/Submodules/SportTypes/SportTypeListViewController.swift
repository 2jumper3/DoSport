//
//  SportTypeListViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class SportTypeListViewController: UIViewController {
    
    var coordinator: SportTypeListCoordinator?
    private let viewModel: SportTypeListViewModel
    
    private lazy var sportTypeListView = self.view as! SportTypeListView
    
    private lazy var collectionManager: SportTypeListDataSource = {
        return $0
    }(SportTypeListDataSource())
    
    private lazy var backBarButton: DSBarBackButton = {
        $0.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return $0
    }(DSBarBackButton())
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(viewModel: SportTypeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = SportTypeListView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.SportTypeList.title
        
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

private extension SportTypeListViewController {
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
        self.sportTypeListView.updateCollectionDataSouce(dateSource: self.collectionManager)
    }
}

//MARK: - SportTypeListViewDelegate

extension SportTypeListViewController: SportTypeListViewDelegate {
    func didTapSaveButton() {
        viewModel.saveData()
    }
}

//MARK: - Actions

@objc
private extension SportTypeListViewController {
    func handleBackButton() {
        coordinator?.goBack()
    }
}
