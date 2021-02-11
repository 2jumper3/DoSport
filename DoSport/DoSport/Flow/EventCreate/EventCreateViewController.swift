//
//  EventCreateViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

final class EventCreateViewController: UIViewController {
    
    var coordinator: EventCreateCoordinator?
    private(set) var viewModel: EventCreateViewModel
    
    private lazy var eventCreateView = view as! EventCreateView
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Init
    
    init(viewModel: EventCreateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        let view = EventCreateView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: - Private methods

private extension EventCreateViewController {
    
    func setupNavBar() {
        title = Texts.EventCreate.navTitle
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Icons.EventCreate.cancel,
            style: .plain,
            target: self,
            action: #selector(handleCancelButton)
        )
    }
}

//MARK: - Actions

@objc
private extension EventCreateViewController {
    
    func handleCancelButton() {
        coordinator?.goBack()
    }
}

