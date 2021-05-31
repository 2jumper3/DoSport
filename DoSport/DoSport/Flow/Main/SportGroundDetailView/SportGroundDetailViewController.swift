//
//  SportGroundDetailViewController.swift
//  DoSport
//
//  Created by Sergey on 28.05.2021.
//

import UIKit

final class SportGroundDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    weak var coordinator: SportGroundDetailCoordinator?
    private lazy var userSubscriberListView = view as! SportGroundDetailView
    private let userSubscriberListCollectionManager = SportGroundDetailDataSource()
    private let viewModel: SportGroundDetailViewModel
    
    private let user: User?
    private let contentType: DSEnums.UserSubscribersContentType
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(
        user: User?,
        contentType: DSEnums.UserSubscribersContentType,
        viewModel: SportGroundDetailViewModel
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
        let view = SportGroundDetailView()
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
        
//        userSubscriberListCollectionManager.updateSegmentedControl(index: self.contentType.index)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.removeDependency(coordinator)
    }
}

//MARK: Private API

private extension SportGroundDetailViewController {
    
    func setupViewModelBindings() {
//        viewModel.onDidLoadSubscribes = { [unowned self] data in
//            self.updateState(data.state)
//        }
        
//        viewModel.onDidLoadSubscriptions = { [unowned self] data in
//            self.updateState(data.state)
//        }
    }
    
    func setupNavBar() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        navigationController?.navigationBar.barStyle = .default
        
        title = "Площадка"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: Fonts.sfProRegular(size: 18),
            NSAttributedString.Key.foregroundColor: Colors.mainBlue
        ]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton.makeBarButton())
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

@objc private extension SportGroundDetailViewController { }

//MARK: - SportGroundDetailViewProtocol -

extension SportGroundDetailViewController: SportGroundDetailViewProtocol {
    
}

//MARK: - UserSubscriberListDataSourceDelegate -

extension SportGroundDetailViewController: SportGroundDetailDataSourceDelegate {
    func collectionDidClickSubscriptions() {
        
    }
    
    func collectionDidClickSubscribers() {
        
    }

    func collectionDidClickOptions(for event: Event?) {
        
    }
    
    
    func collectionViewNeedsReloadData() {
        
    }
    
    func collectionView(didSelect user: User?) {
//        coordinator?.goToSelectedUserPageModule(with: user)
    }
}


