//
//  UserSubscriberListController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import UIKit

final class UserSubscriberListController: UIViewController, UIGestureRecognizerDelegate {
    
    weak var coordinator: UserSubscriberListCoordinator?
    private lazy var userSubscriberListView = view as! UserSubscriberListView
    private let userSubscriberListCollectionManager = UserSubscriberListDataSource()
    
    private let user: User?
    private let selectedSegmentedControlIndex: Int
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(user: User?, segmentedControlIndex index: Int) {
        self.user = user
        self.selectedSegmentedControlIndex = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = UserSubscriberListView()
        view.delegate = self
        userSubscriberListCollectionManager.delegate = self
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let navController = self.navigationController as? DSNavigationController else { return }
        navController.hasSeparator(false)
        
        setupNavBar()
        
        prepareTableData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        userSubscriberListCollectionManager.updateSegmentedControl(index: selectedSegmentedControlIndex)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.removeDependency(coordinator)
    }
}

//MARK: Private API

private extension UserSubscriberListController {
    
    func prepareTableData() {
//        guard let user = user, let name = user.name else { return }
        
        /// as we get user, we need to take his array of subsribers and subscribed users and prepare this data for dataSource
        
        userSubscriberListView.updateCollectionDataSource(dateSource: userSubscriberListCollectionManager)
        updateView()
    }
    
    func updateView() {
        userSubscriberListView.updateCollectionDataSource(dateSource: userSubscriberListCollectionManager)
    }
    
    func setupNavBar() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        navigationController?.navigationBar.barStyle = .default
        
        title = user?.name
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: Fonts.sfProRegular(size: 18),
            NSAttributedString.Key.foregroundColor: Colors.mainBlue
        ]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: DSBarBackButton())
    }
}

//MARK: Actions

@objc private extension UserSubscriberListController { }

//MARK: - UserSubscriberListViewDelegate -

extension UserSubscriberListController: UserSubscriberListViewDelegate { }

//MARK: - UserSubscriberListDataSourceDelegate -

extension UserSubscriberListController: UserSubscriberListDataSourceDelegate {
    
    func collectionViewNeedsReloadData() {
        updateView()
    }
    
    func collectionView(didSelect user: User?) {
        coordinator?.goToSelectedUserPageModule(with: user)
    }
}
