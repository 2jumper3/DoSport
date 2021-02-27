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
    
    let user: User?
    
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
        view.delegate = self
        userMainCollectionManager.delegate = self
        navBar.delegate = self
        
        navigationItem.titleView = navBar
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let navController = self.navigationController as? DSNavigationController else { return }
        navController.hasSeparator(false)
        
        setupViewModelBindings()
        
        viewModel.prepareEventData()
        userMainView.updateCollectionDataSource(dateSource: userMainCollectionManager)
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
        viewModel.onDidPrepareEventsData = { [weak self] events in
            self?.userMainCollectionManager.events = events
            self?.updateView()
        }
    }
    
    func updateView() {
        userMainView.updateCollectionDataSource(dateSource: self.userMainCollectionManager)
    }
}

//MARK: Actions

@objc private extension UserMainController { }

//MARK: - UserMainViewDelegate -

extension UserMainController: UserMainViewDelegate { }

//MARK: - UserMainDataSourceDelegate -

extension UserMainController: UserMainDataSourceDelegate {
    
    func collectionViewNeedsReloadData() {
        userMainView.updateCollectionDataSource(dateSource: userMainCollectionManager)
    }
    
    func collectionDidClickSubscribes() {
        coordinator?.goToUserSubscribtionListModule()
    }
    
    func collectionDidClickSubscribers() {
        coordinator?.goToUserSubscribtionListModule()
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
    
    func closeButtonClicked() {
        
    }
    
    func editButtonClicked() {
        
    }
    
    func deleteButtonClicked() {
        
    }
}
