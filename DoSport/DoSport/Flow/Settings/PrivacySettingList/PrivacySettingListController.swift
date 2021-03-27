//
//  PrivacySettingListController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

final class PrivacySettingListController: UIViewController, UIGestureRecognizerDelegate {
    
    weak var coordinator: PrivacySettingListCoordinator?
    private lazy var privacySettingListView = view as! PrivacySettingListView
    private let privacySettingListDataSource = PrivacySettingListDataSource()
    
    private let compilation: (PrivacySettingType) -> Swift.Void
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(compilation: @escaping (PrivacySettingType) -> Swift.Void) {
        self.compilation = compilation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = PrivacySettingListView()
        view.delegate = self
        privacySettingListDataSource.delegate = self
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        privacySettingListView.updateCollectionDataSource(dateSource: privacySettingListDataSource)
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

private extension PrivacySettingListController {
    
    func setupNavBar() {
        title = Texts.PrivacySettingList.title
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let backBarButton = DSBarBackButton()
        backBarButton.addTarget(self, action: #selector(handleGoBackButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)
    }
}

//MARK: Actions

@objc private extension PrivacySettingListController {
    
    func handleGoBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - PrivacySettingListViewDelegate -

extension PrivacySettingListController: PrivacySettingListViewDelegate { }

//MARK: - PrivacySettingListDataSourceDelegate -

extension PrivacySettingListController: PrivacySettingListDataSourceDelegate {
    
    func tableView(didSelect privacySetting: PrivacySettingType) {
        compilation(privacySetting)
    }
}
