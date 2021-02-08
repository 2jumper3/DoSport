//
//  CountryCodeListViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import UIKit

final class CountryCodeListViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var coordinator: CountryCodeListCoordinator?
    let viewModel: CountryCodeListViewModel
    
    private lazy var countryView = self.view as! CountryCodeListView
    private lazy var navBar = DSCountryListNavBar()
    
    private lazy var tableManager: CountryCodeListDataSource = {
        $0.onCountryDidSelect = { [weak self] country in
            guard self != nil else { return }
            hideKeyboard(for: self!.navBar.getSeachBar()) {
                self!.coordinator?.goBack(with: country)
            }
        }
        return $0
    }(CountryCodeListDataSource())
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Init
    
    init(viewModel: CountryCodeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cicle
    
    override func loadView() {
        let view = CountryCodeListView()
        self.view = view
        navigationItem.titleView = navBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self;
        
        setupNavBar()
        setupViewModel()
        
        viewModel.loadCountries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: - Private methods

private extension CountryCodeListViewController {
    func setupNavBar() {
        navBar.title = Texts.CountryList.title
        navigationItem.setHidesBackButton(true, animated: true)
        
        navBar.onSearchButtonDidTap = { [weak self] text in
            self?.viewModel.prepareCountriesToSearch(by: text)
        }
        
        navBar.onSeachBarDidChageText = { [weak self] text in
            self?.viewModel.prepareCountriesToSearch(by: text)
        }
        
        navBar.onBackButtonDidTap = { [weak self] in
            self?.coordinator?.goBack()
        }
    }
    
    func setupViewModel() {
        viewModel.onSectionsDidSet = { [weak self] sections in
            self?.tableManager.viewModels = sections
            self?.updateView()
        }
        
        viewModel.onCountryDidNotMatch = { [weak self] in
            self?.countryView.updateView()
        }
    }
    
    func updateView() {
        countryView.updateTableViewData(dataSource: self.tableManager)
    }
}

//MARK: - Actions
@objc extension CountryCodeListViewController {
    private func handleGoBackButton() {
        coordinator?.goBack()
    }
}
