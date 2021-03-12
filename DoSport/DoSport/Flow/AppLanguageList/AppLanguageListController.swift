//
//  AppLanguageListController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit
import DoSportSwiftUI

#if canImport(SwiftUI)
import SwiftUI
#endif

final class AppLanguageListController: UIViewController, UIGestureRecognizerDelegate {
    
    weak var coordinator: AppLanguageListCoordinator?
    private lazy var appLanguageListView = view as! AppLanguageListView
    private let appLanguageListManager = AppLanguageListDataSource()
    
    private let compilation: (String) -> Swift.Void
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(compilation: @escaping (String) -> Swift.Void) {
        self.compilation = compilation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = AppLanguageListView()
        view.delegate = self
        appLanguageListManager.delegate = self
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            let hostingController = UIHostingController(rootView: AuthViewSUI())
            
            addChild(hostingController)
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)
            
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                hostingController.view.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        } else {
            
        }
        
        setupNavBar()
        appLanguageListView.updateCollectionDataSource(dateSource: appLanguageListManager)
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

private extension AppLanguageListController {
    
    func setupNavBar() {
        title = Texts.Common.language
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let backBarButton = DSBarBackButton()
        backBarButton.addTarget(self, action: #selector(handleGoBackButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)
    }
}

//MARK: Actions

@objc private extension AppLanguageListController {
    
    func handleGoBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - AppLanguageListViewDelegate -

extension AppLanguageListController: AppLanguageListViewDelegate { }

//MARK: - AppLanguageListDataSourceDelegate -

extension AppLanguageListController: AppLanguageListDataSourceDelegate {
    
    func tableView(didSelect sound: String) {
        compilation(sound)
    }
}
