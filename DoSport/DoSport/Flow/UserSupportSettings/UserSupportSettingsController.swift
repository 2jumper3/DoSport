//
//  UserSupportSettingsController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

final class UserSupportSettingsController: UIViewController, UIGestureRecognizerDelegate {
    
    weak var coordinator: UserSupportSettingsCoordinator?
    private lazy var userSupportSettingsView = view as! UserSupportSettingsView
    private let userSupportSettingsTableManage = UserSupportSettingsDataSource()
    
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
        let view = UserSupportSettingsView()
        view.delegate = self
        userSupportSettingsTableManage.delegate = self
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        userSupportSettingsView.updateCollectionDataSource(dateSource: userSupportSettingsTableManage)
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

private extension UserSupportSettingsController {
    
    func setupNavBar() {
        title = Texts.UserSupportSettings.title
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let backBarButton = DSBarBackButton()
        backBarButton.addTarget(self, action: #selector(handleGoBackButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)
    }
}

//MARK: Actions

@objc private extension UserSupportSettingsController {
    
    func handleGoBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UserSupportSettingsViewDelegate -

extension UserSupportSettingsController: UserSupportSettingsViewDelegate { }

//MARK: - PrivacySettingListDataSourceDelegate -

extension UserSupportSettingsController: UserSupportSettingsDataSourceDelegate {
    
    func tableView(didSelect userSupportCell: UserSupportCellType) {
        switch userSupportCell {
        case .problemReport: coordinator?.goToProblemReportModule()
        case .supportRequest: coordinator?.goToSupportRequestModule()
        case .dataUsagePolicy: coordinator?.goToDataUsagePolicyModule()
        case .appUsagePolicy: coordinator?.goToAppUsagePolicyModule()
        }
    }
}
