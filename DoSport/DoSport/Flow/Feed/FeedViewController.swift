//
//  FeedViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class FeedViewController: UIViewController {
    
    var coordinator: FeedCoordinator?
    private let viewModel: FeedViewModel
    
    private lazy var feedView = self.view as! FeedView
    
    private let navBar = DSHomeNavBar()
    
    private lazy var collectionViewManager: FeedDataSource = {
        return $0
    }(FeedDataSource())

    // MARK: - Init
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        let view = FeedView()
        self.view = view
        
        navigationItem.titleView = navBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Texts.Feed.feedTitle
        navigationItem.setHidesBackButton(true, animated: true)
        
        navBar.createEventButton.addTarget(
            self,
            action: #selector(handleCreateEventButton),
            for: .touchUpInside
        )
        
        setupViewsTargets()
        setupCollectionViewBinding()
        setupViewModelBinding()
        
        viewModel.prepareEventsData()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: - Private methods

private extension FeedViewController {
    
    func setupViewsTargets() {
        
        // filter view buttons
        feedView.filterButtonsView.allButton.addTarget(
            self,
            action: #selector(handleFilterViewAllButton),
            for: .touchUpInside
        )
        
        feedView.filterButtonsView.subscribesButton.addTarget(
            self,
            action: #selector(handleFilterViewSubscribesButton),
            for: .touchUpInside
        )
        
        feedView.filterButtonsView.subscribersButton.addTarget(
            self,
            action: #selector(handleFilterViewSubscribersButton),
            for: .touchUpInside
        )
        
        navBar.createEventButton.addTarget(
            self,
            action: #selector(handleCreateEventButton),
            for: .touchUpInside
        )
    }
    
    func setupCollectionViewBinding() {
        collectionViewManager.onDidSelectEvent = { [weak self] event in
            self?.coordinator?.goToEventModule(withSelected: event)
        }
    }
    
    func setupViewModelBinding() {
        viewModel.onDidPrepareEventsData = { [weak self] events in
            guard self != nil else { return }
            
            self?.collectionViewManager.viewModels = events
            self?.updateView()
        }
    }
    
    func updateView() {
        feedView.updateCollectionDataSource(dateSource: collectionViewManager)
    }
}

//MARK: - Actions

@objc
private extension FeedViewController {
    
    func handleCreateEventButton() {
        print(#function)
    }
    
    func handleFilterViewAllButton(_ button: FeedFilterButton) {
        let subscribersButton = feedView.filterButtonsView.subscribersButton
        let subscribesButton = feedView.filterButtonsView.subscribesButton
        
        if button.getState() == .notSelected
            && (subscribersButton.getState() == .selected
            && subscribesButton.getState() == .selected) {
            
            button.bind()
            subscribersButton.bind(state: .notSelected)
            subscribesButton.bind(state: .notSelected)
        } else {
            button.bind()
        }
    }
    
    func handleFilterViewSubscribesButton(_ button: FeedFilterButton) {
        let subscribersButton = feedView.filterButtonsView.subscribersButton
        let allButton = feedView.filterButtonsView.allButton
        
        if subscribersButton.getState() == .selected && allButton.getState() == .selected {
            allButton.bind()
            button.bind()
        } else {
            button.bind()
        }
    }
    
    func handleFilterViewSubscribersButton(_ button: FeedFilterButton) {
        let subscribesButton = feedView.filterButtonsView.subscribesButton
        let allButton = feedView.filterButtonsView.allButton
        
        if subscribesButton.getState() == .selected && allButton.getState() == .selected {
            allButton.bind()
            button.bind()
        } else {
            button.bind()
        }
    }
}
