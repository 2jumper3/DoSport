//
//  CountryListViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import UIKit

final class CountryListViewController: UIViewController {
    
    var coordinator: CountryListCoordinator?
    let viewModel: CountryListViewModel
    
    private lazy var countryView = self.view as! CountryListView
    
    private lazy var navBar: DSNavBar = {
        $0.searchBarDelegate = self
        return $0
    }(DSNavBar())
    
    private lazy var tableManager: CountryListDataSource = {
        $0.onCountryDidSelect = { [weak self] country in
            self?.coordinator?.goBack(with: country)
        }
        return $0
    }(CountryListDataSource())

    
    private lazy var goBackButton = DSBarBackButton(target: self, action: #selector(handleGoBackButton))
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Init
    
    init(viewModel: CountryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cicle
    
    override func loadView() {
        let view = CountryListView()
        self.view = view
        navigationItem.titleView = navBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        loadCountries()
    }
}

//MARK: - Private methods
private extension CountryListViewController {
    func setupNavBar() {
        navBar.title = Texts.CountryList.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: goBackButton)
    }
    
    func loadCountries() {
        viewModel.onCountriesDidLoad = { [weak self] countries in
            self?.tableManager.viewModels = countries
            self?.updateView()
        }
        
        viewModel.loadCountries()
    }
    
    func updateView() {
        countryView.updateTableViewData(dataSource: self.tableManager)
    }
}

//MARK: - Actions
@objc extension CountryListViewController {
    private func handleGoBackButton() {
        coordinator?.goBack()
    }
}
