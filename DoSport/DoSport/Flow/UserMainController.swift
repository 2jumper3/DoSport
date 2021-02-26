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
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
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
        
        navigationItem.largeTitleDisplayMode = .always
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
    
    func setupNavBar() {
        title = user?.name
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = Colors.darkBlue
        
        let settingsIconButton = UIButton(type: .system)
        settingsIconButton.setImage(Icons.UserMain.settings, for: .normal)
        settingsIconButton.tintColor = .white
        settingsIconButton.addTarget(self, action: #selector(handleSettingsButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsIconButton)
    }
}

//MARK: Actions

@objc private extension UserMainController {
    
    func handleSettingsButton() {
        coordinator?.goToSettingsMainListModule()
    }
}

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
}
