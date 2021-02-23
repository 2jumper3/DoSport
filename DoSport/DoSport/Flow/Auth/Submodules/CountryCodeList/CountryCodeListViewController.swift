//
//  CountryCodeListViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import UIKit

final class CountryCodeListViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var coordinator: CountryCodeListCoordinator?
    private let viewModel: CountryCodeListViewModel
    private let tableManager = CountryCodeListDataSource()
    private lazy var countryView = self.view as! CountryCodeListView
    
    private lazy var navBar = DSCountryListNavBar()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Init
    
    init(viewModel: CountryCodeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cicle
    
    override func loadView() {
        let view = CountryCodeListView()
        self.view = view
        navigationItem.titleView = navBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self;
        
        tableManager.delegate = self
        
        setupNavBar()
        setupViewModelBindings()
        
        viewModel.loadCountries()
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

private extension CountryCodeListViewController {
    
    func setupNavBar() {
        navBar.title = Texts.CountryList.title
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func setupViewModelBindings() {
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

//MARK: Actions

@objc private extension CountryCodeListViewController {
    
    func handleGoBackButton() {
        coordinator?.goBack()
    }
}

//MARK: - CountryCodeListDataSourceDelegate -

extension CountryCodeListViewController: CountryCodeListDataSourceDelegate {
    
    func tableView(didSelect country: Country) {
        navBar.resignSearchBarFirstResponder()
        coordinator?.goBack(with: country)
    }
}

//MARK: - DSCountryListNavBarDelegate -

extension CountryCodeListViewController: DSCountryListNavBarDelegate {
    
    func searchButtonClicked(with text: String) {
        viewModel.prepareCountriesToSearch(by: text)
    }
    
    func searchTextChanged(text: String) {
        viewModel.prepareCountriesToSearch(by: text)
    }
    
    func navBarBackButtonClicked() {
        coordinator?.goBack()
    }
}
 
