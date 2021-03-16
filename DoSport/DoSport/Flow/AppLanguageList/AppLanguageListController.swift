//
//  AppLanguageListController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

/// Describes handling view events and user interactions in App Language selection screen.
final class AppLanguageListController: UIViewController, UIGestureRecognizerDelegate {
    
    /// Coordinator object that's used to call nagication methods
    weak var coordinator: AppLanguageListCoordinator?
    
    /// Custom view containing all UI elements and their layouts
    private lazy var appLanguageListView = view as! AppLanguageListView
    
    /// Manager object  handles all tableView's dataSource & delegate methods
    private let appLanguageListManager = AppLanguageListDataSource()
    
    /// Compilation that returns app language to the previous screen when user selects.
    ///
    /// - Parameters:
    ///     - language: the app language that is `String` which user can select when clicking cell
    private let compilation: (_ language: String) -> Swift.Void
    
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
        
        setupNavBar()
        appLanguageListView.updateCollectionDataSource(dataSource: appLanguageListManager)
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
    
    /// Sets navigation bar title text, back bar button and gesture recogniser to go back by swipe
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
    
    /// Called when user selects app sound setting from the list of sounds
    /// - Parameters:
    ///     - language: The language `string` name inside tableCell that user can select
    func tableView(didSelect language: String) {
        compilation(language)
    }
}
