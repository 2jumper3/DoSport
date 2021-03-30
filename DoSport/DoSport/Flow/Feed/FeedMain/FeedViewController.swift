//
//  FeedViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class FeedViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    private let viewModel: FeedViewModel
    private lazy var feedView = self.view as! FeedView
    private let collectionViewManager = FeedDataSource()
    
    private let navBar = DSFeedNavBar()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = FeedView()
        view.delegate = self
        self.view = view
        
        navigationItem.titleView = navBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Texts.Feed.feedTitle
        
        collectionViewManager.delegate = self
        navBar.delegate = self

        setupViewModelBinding()
        
        viewModel.prepareEventsData()
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

private extension FeedViewController {
    
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

//MARK: Actions

@objc private extension FeedViewController {
    
    func handleCreateEventButton() {
        coordinator?.goToEventCreateModule()
    }
}

//MARK: - FeedViewDelegate -

extension FeedViewController: FeedViewDelegate {
    
    func allFilterButtonClicked() {
        /// viewModel method should be called to filter the feed
    }
    
    func mySubscribesFilterButtonClicked() {
        /// viewModel method should be called to filter the feed
    }
    
    func mySportGroundsFilterButtonClicked() {
        /// viewModel method should be called to filter the feed
    }
}

//MARK: - FeedDataSourceDelegate -

extension FeedViewController: FeedDataSourceDelegate {
    
    func collectionView(didSelect event: Event) {
        coordinator?.goToEventModule(withSelected: event)
    }
}

//MARK: - DSFeedNavBarDelegate -

extension FeedViewController: DSFeedNavBarDelegate {
    
    func createButtonClicked() {
        coordinator?.goToEventCreateModule()
    }
}
