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
    private let viewModel: UserSubscriberListViewModel
    
    private let user: User?
    private let contentType: DSEnums.UserSubscribersContentType
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(
        user: User?,
        contentType: DSEnums.UserSubscribersContentType,
        viewModel: UserSubscriberListViewModel
    ) {
        self.user = user
        self.viewModel = viewModel
        self.contentType = contentType
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

        switch self.contentType {
        case .subscribers: viewModel.doLoadSubscribers(request: .init())
        case .subscriptions: viewModel.doLoadSubscriptions(request: .init())
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        userSubscriberListCollectionManager.updateSegmentedControl(index: self.contentType.index)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.removeDependency(coordinator)
    }
}

//MARK: Private API

private extension UserSubscriberListController {
    
    func setupViewModelBindings() {
        viewModel.onDidLoadSubscribes = { [unowned self] data in
            self.updateState(data.state)
        }
        
        viewModel.onDidLoadSubscriptions = { [unowned self] data in
            self.updateState(data.state)
        }
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
    
    func updateState(_ state: UserSubscriberListDataFlow.ViewControllerState) {
        switch state {
        case .loading:
            break
        case .failed:
            break
        case .success(let data):
            debugPrint(data)
            break
        }
    }
}

//MARK: Actions

@objc private extension UserSubscriberListController { }

//MARK: - UserSubscriberListViewDelegate -

extension UserSubscriberListController: UserSubscriberListViewDelegate { }

//MARK: - UserSubscriberListDataSourceDelegate -

extension UserSubscriberListController: UserSubscriberListDataSourceDelegate {
    
    func collectionViewNeedsReloadData() {
        
    }
    
    func collectionView(didSelect user: User?) {
        coordinator?.goToSelectedUserPageModule(with: user)
    }
}
