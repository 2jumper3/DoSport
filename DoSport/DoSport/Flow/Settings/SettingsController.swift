//
//  SettingsController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import UIKit

final class SettingsController: UIViewController, UIGestureRecognizerDelegate {
    
    weak var coordinator: SettingsCoordinator?
    private lazy var settingsView = view as! SettingsView
    private let settingsTableManager = SettingsDataSource()
    
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
        let view = SettingsView()
        view.delegate = self
        settingsTableManager.delegate = self
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        settingsView.updateCollectionDataSource(dateSource: settingsTableManager)
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

private extension SettingsController {
    
    func setupNavBar() {
        title = "Настройки"
        
        guard let navBarController = navigationController as? DSNavigationController else { return }
        
        navBarController.hasSeparator(true)
        navBarController.interactivePopGestureRecognizer?.delegate = self
        
        let backBarButton = DSBarBackButton()
        backBarButton.addTarget(self, action: #selector(handleGoBackButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)
    }
}

//MARK: Actions

@objc private extension SettingsController {
    
    func handleGoBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - SettingsViewDelegate -

extension SettingsController: SettingsViewDelegate { }

//MARK: - SettingsDataSourceDelegate -

extension SettingsController: SettingsDataSourceDelegate {
  
    func tableView(didSelect cellType: SettingCellType) {
        switch cellType {
        case .account:
            coordinator?.goToUserAccountEditingModule()
        case .alerts(_, let title):
            coordinator?.goToNotificationSettingsModule(with: title)
        case .privacy:
            coordinator?.goToPrivacySettingsModule() { privacyMode in
                print(privacyMode) /// use it later while implementing back-end
                /// TODO: implement selected privacy mode persistency and using that mode when go again to privacy screen
            }
        case .language(_, let title):
            coordinator?.goToLanguageListModule(with: title)
        case .help(_, let title):
            coordinator?.goToSupportSettingsModule(with: title)
        }
    }
}

