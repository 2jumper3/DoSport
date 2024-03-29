//
//  UserMainController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import UIKit

final class UserMainController: UIViewController {
    
    weak var coordinator: UserMainCoordinator?
    private let viewModel: UserMainViewModel
    private lazy var userMainView = view as! UserMainView
    private let userMainCollectionManager = UserMainDataSource()
    
    private let user: User?
    
    private var viewState: UserMainDataFlow.ViewControllerState<DSEmptyRequest> = .loading
    
    private lazy var navBar = DSUserMainNavBar(userName: self.user?.name)
    
    private var eventInviteContainerController: EventInviteViewController?
    private var eventManageContanerController: EventManageContanerViewController?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(viewModel: UserMainViewModel, user: User?) {
        self.viewModel = viewModel
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = UserMainView()
        userMainCollectionManager.delegate = self
        navBar.delegate = self
        
        navigationItem.titleView = navBar
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let navController = self.navigationController as? DSNavigationController else { return }
        navController.hasSeparator(false)
        
        if case .loading = self.viewState {
            userMainView.updateViewToState(self.viewState)
        }
        
        self.setupViewModelBindings()
        self.viewModel.doLoadEvents(request: .init(userID: self.user?.id ?? 0))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setup(&eventInviteContainerController)
        eventInviteContainerController?.delegate = self // TODO: Create base generic container class
        setup(&eventManageContanerController)
        eventManageContanerController?.delegate = self // TODO: Create base generic container class
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.removeDependency(coordinator)
    }
}

//MARK: Private API

private extension UserMainController {
    
    func setupViewModelBindings() {
        viewModel.didLoadEvents = { [unowned self] data in
            self.updateState(data.state)
        }
        
        viewModel.didLoadSportGrounds = { [unowned self] data in
            self.updateState(data.state)
        }
    }
    
    func updateState<T>(_ state: UserMainDataFlow.ViewControllerState<T>) where T: Codable {
        switch state {
        case .loading:
            self.userMainView.updateViewToState(state)
        case .failed:
            self.userMainView.updateViewToState(state)
        case .success(let data):
            
            if let viewModels = data as? [DSModels.Event.EventView] {
                self.userMainCollectionManager.events = viewModels
                
            } else if let viewModels = data as? [DSModels.SportGround.SportGroundResponse] {
                self.userMainCollectionManager.sportGrounds = viewModels
            }
            
            self.userMainView.updateCollectionDataSource(dateSource: userMainCollectionManager)
            self.userMainView.updateViewToState(state)
        }
    }
}

//MARK: - UserMainDataSourceDelegate -

extension UserMainController: UserMainDataSourceDelegate {
    
    func collectionViewNeedsReloadData() {
        userMainView.updateCollectionDataSource(dateSource: userMainCollectionManager)
    }
    
    func collectionDidClickSubscribers() {
        /// Zero here means that when user clicks `Subscribes` it is gonna open next screen that has segmentedControl,
        /// which shows user's subscribed members at `0` and subscribers at `1`, passing index we let VC to know what to show
        coordinator?.goToUserSubscribtionListModule(.subscribers, with: user)
    }
    
    func collectionDidClickSubscriptions() {
            /// Zero here means that when user clicks `Subscriptions` it is gonna open next screen that has segmentedControl,
            /// which shows user's subscribed members at `0` and subscribers at `1`, passing index we let VC to know what to show
            coordinator?.goToUserSubscribtionListModule(.subscriptions, with: user)
    }
    
    func collectionDidClickOptions(for event: Event?) {
        present(eventManageContanerController)
    }
}

//MARK: - DSUserMainNavBarDelegate -

extension UserMainController: DSUserMainNavBarDelegate {
    
    func settingsButtonClicked() {
        coordinator?.goToSettingsMainListModule()
    }
}

//MARK: - EventInviteViewControllerDelegate -

extension UserMainController: EventInviteViewControllerDelegate {
    func shareButtonClicked() { }
    
    func cancelButtonClicked() {
        dismiss(eventInviteContainerController, from: userMainView)
    }
}

//MARK: - EventManageContanerViewControllerDelegate -

extension UserMainController: EventManageContanerViewControllerDelegate {
    
    func touchBegan() {
        
    }
    
    func eventManageCancelButtonClicked() {
        dismiss(eventManageContanerController, from: userMainView)
    }
    
    func inviteButtonClicked() {
        dismiss(eventManageContanerController, from: userMainView) { [unowned self] in
            eventInviteContainerController?.setupKeyboardNotification()
            present(eventInviteContainerController)
        }
    }
    
//    func closeButtonClicked() {
//
//    }
    
    func editButtonClicked() {
        
    }
    
    func deleteButtonClicked() {
        
    }
}
