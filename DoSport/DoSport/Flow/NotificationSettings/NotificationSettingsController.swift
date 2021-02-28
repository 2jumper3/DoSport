//
//  NotificationSettingsController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

final class NotificationSettingsController: UIViewController, UIGestureRecognizerDelegate {
    
    weak var coordinator: NotificationSettingsCoordinator?
    private lazy var notificationSettingsView = view as! NotificationSettingsView
    private let notificationSettingsTableManager = NotificationSettingsDataSource()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = NotificationSettingsView()
        view.delegate = self
        notificationSettingsTableManager.delegate = self
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        notificationSettingsView.updateCollectionDataSource(dateSource: notificationSettingsTableManager)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.removeDependency(coordinator)
    }
}

//MARK: Private API

private extension NotificationSettingsController {
    
    func setupNavBar() {
        title = Texts.NotificationSettings.title
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let backBarButton = DSBarBackButton()
        backBarButton.addTarget(self, action: #selector(handleGoBackButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)
    }
}

//MARK: Actions

@objc private extension NotificationSettingsController {
    
    func handleGoBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - NotificationSettingsViewDelegate -

extension NotificationSettingsController: NotificationSettingsViewDelegate { }

//MARK: - NotificationSettingsDataSourceDelegate -

extension NotificationSettingsController: NotificationSettingsDataSourceDelegate {
  
    func tableViewDidSelectSoundCell() {
        
    }
}
