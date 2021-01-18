//
//  HomeViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var coordinator: HomeCoordinator?
    private let viewModel: HomeViewModel
    
    private lazy var homeView = self.view as! HomeView
    
    private let navBar = DSHomeNavBar()

    // MARK: - Init
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        let view = HomeView()
        view.delegate = self
        self.view = view
        
        navigationItem.titleView = navBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        navigationItem.setHidesBackButton(true, animated: true)
        
        navBar.createEventButton.addTarget(
            self,
            action: #selector(handleCreateButton),
            for: .touchUpInside
        )
        
        viewModel.prepareEventsData()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
}

//MARK: - Actions

@objc
private extension HomeViewController {
    func handleCreateButton() {
        
    }
}

//MARK: - HomeViewDelegate

extension HomeViewController: HomeViewDelegate {

}
