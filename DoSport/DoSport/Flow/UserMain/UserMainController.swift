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
        
        setupEventInviteContainer()
        setupEventManageContainer()
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
    
    func setupEventInviteContainer() {
        eventInviteContainerController = EventInviteViewController(
            nibName: "EventInviteViewController",
            bundle: nil
        )
        eventInviteContainerController?.delegate = self
        
        eventInviteContainerController?.view.frame = tabBarController!.view.frame
        eventInviteContainerController?.view.frame.origin.y = tabBarController!.view.frame.maxY
    }
    
    func setupEventManageContainer() {
        eventManageContanerController = EventManageContanerViewController(
            nibName: "EventManageContanerViewController",
            bundle: nil
        )
        eventManageContanerController?.delegate = self
        
        eventManageContanerController?.view.frame = tabBarController!.view.frame // FIXME: remove force
        eventManageContanerController?.view.frame.origin.y = tabBarController!.view.frame.maxY
    }
    
    func presentEventInviteContainer() {
        guard let container = eventInviteContainerController else { return }
        
        tabBarController?.view.addSubview(container.view)
        tabBarController?.addChild(container)
        container.didMove(toParent: tabBarController)
        
        let y: CGFloat = view.frame.maxY - container.view.frame.height - 10
        
        UIView.animate(withDuration: 0.3) {
            container.view.frame.origin.y = y
        } completion: { value in
            UIView.animate(withDuration: 0.3) {
                container.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            }
        }
    }
    
    func dismissEventInviteContainer() {
        guard let container = eventInviteContainerController else { return }
        
        UIView.animate(withDuration: 0.3) {
            UIView.animate(withDuration: 0.3) {
                container.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            } completion: { value in
                UIView.animate(withDuration: 0.3) { [unowned self] in
                    container.view.frame.origin.y = userMainView.frame.maxY
                } completion: { value in
                    container.willMove(toParent: nil)
                    container.removeFromParent()
                    container.view.removeFromSuperview()
                }
            }
        }
    }

    
    func presentEventManageContainer() {
        guard let container = eventManageContanerController else { return }
        
        tabBarController?.view.addSubview(container.view)
        tabBarController?.addChild(container)
        container.didMove(toParent: tabBarController)
        
        let y: CGFloat = view.frame.maxY - container.view.frame.height - 10
        
        UIView.animate(withDuration: 0.3) {
            container.view.frame.origin.y = y
        } completion: { value in
            UIView.animate(withDuration: 0.3) {
                container.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            }
        }
    }
    
    func dismissEventManageContainer(completion: @escaping () -> Swift.Void = { return }) {
        guard let container = eventManageContanerController else { return }
        
        UIView.animate(withDuration: 0.2) {
            UIView.animate(withDuration: 0.15) {
                container.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            } completion: { value in
                UIView.animate(withDuration: 0.1) { [unowned self] in
                    container.view.frame.origin.y = userMainView.frame.maxY
                } completion: { value in
                    container.willMove(toParent: nil)
                    container.removeFromParent()
                    container.view.removeFromSuperview()
                    completion()
                }
            }
        }
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
        presentEventManageContainer()
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
        dismissEventInviteContainer()
    }
}

//MARK: - EventManageContanerViewControllerDelegate -

extension UserMainController: EventManageContanerViewControllerDelegate {
    
    func touchBegan() {
        
    }
    
    func eventManageCancelButtonClicked() {
        dismissEventManageContainer()
    }
    
    func inviteButtonClicked() {
        dismissEventManageContainer() { [unowned self] in
            eventInviteContainerController?.setupKeyboardNotification()
            presentEventInviteContainer()
        }
    }
    
    func closeButtonClicked() {
        
    }
    
    func editButtonClicked() {
        
    }
    
    func deleteButtonClicked() {
        
    }
}
