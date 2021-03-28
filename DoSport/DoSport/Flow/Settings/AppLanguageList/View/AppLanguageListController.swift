//
//  AppLanguageListController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

/// Describes handling view events and user interactions in App Language selection screen.
final class AppLanguageListController: UIViewController, UIGestureRecognizerDelegate {
    
    weak var coordinator: AppLanguageListCoordinator?
    
    private var viewModel: AppLanguageViewModel
    
    private lazy var appLanguageListView = view as! AppLanguageListView
    
    private let appLanguageListManager = AppLanguageListDataSource()
    
    /// Compilation that returns app language to the previous screen when user selects.
    ///
    /// - Parameters:
    ///     - language: the app language that is `AppLanguageModel.Language` which user can select when clicking cell
    private let compilation: (_ language: AppLanguageModel.Language) -> Swift.Void
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(
        viewModel: AppLanguageViewModel,
        compilation: @escaping (AppLanguageModel.Language) -> Swift.Void
    ) {
        self.viewModel = viewModel
        self.compilation = compilation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = AppLanguageListView()
        appLanguageListManager.delegate = self
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavBar()
        self.updateView()
        self.compilation(viewModel.languages[viewModel.choosenLanguageIndex])
        self.setupViewModelBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: Private API

private extension AppLanguageListController {
    
    func updateView() {
        self.appLanguageListManager.viewModels = viewModel.languages
        self.appLanguageListView.updateCollectionDataSource(dataSource: appLanguageListManager)
    }
    
    func setupViewModelBindings() {
        viewModel.onDidSelectLanaguage = { [unowned self] data in
            switch data {
            case .loading:
                break
            case .failed:
                break
            case .success:
                self.updateView()
            }
        }
    }
    
    /// Sets navigation bar title text, back bar button and gesture recogniser to go back by swipe
    func setupNavBar() {
        title = Texts.Common.language
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let backBarButton = UIButton.makeBarButton()
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

//MARK: - AppLanguageListDataSourceDelegate -

extension AppLanguageListController: AppLanguageListDataSourceDelegate {
    
    /// Called when user selects app sound setting from the list of languages
    ///
    /// - Parameters:
    ///     - language: The language `AppLanguageModel.Language` name inside tableCell that user can select
    func tableView(didSelect language: AppLanguageModel.Language) {
        self.viewModel.chooseLanguage(language)
        self.compilation(language)
    }
}
