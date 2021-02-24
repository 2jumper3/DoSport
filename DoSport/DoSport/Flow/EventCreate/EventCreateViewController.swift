//
//  EventCreateViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

final class EventCreateViewController: UIViewController {
    
    weak var coordinator: EventCreateCoordinator?
    private let viewModel: EventCreateViewModel
    private lazy var eventCreateView = view as! EventCreateView
    private let tableManager = EventCreateDataSource()
    
    /// to provide title to the playground selection screen in order to define sport type. Used when tapped
    /// playground selection cell in this class's EventCreateDataSourceDelegate part below
    private var sportTypeTitle: String?
    
    /// to provide title to the date selection screen in order to define in what playground user can book time.
    /// Uused when tapped date selection cell in this class's EventCreateDataSourceDelegate part below
    private var sportGroundTitle: String?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(viewModel: EventCreateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = EventCreateView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableManager.delegate = self
        
        setupNavBar()
        
        eventCreateView.updateTableDataSource(dataSource: self.tableManager)
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

private extension EventCreateViewController {
    
    func setupNavBar() {
        title = Texts.EventCreate.navTitle
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Colors.mainBlue
        ]
        
        let button = UIButton(type: .system)
        button.setImage(Icons.EventCreate.cancel, for: .normal)
        button.tintColor = Colors.mainBlue
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
}

//MARK: Actions

@objc private extension EventCreateViewController {
    
    func handleCancelButton() {
        coordinator?.goBack()
    }
}

//MARK: - EventCreateViewDelegate -

extension EventCreateViewController: EventCreateViewDelegate {
    
    func createButtonClicked() {
        /// by sending to viewModel all data needed for `Event` object creation this method should call viewModel's method
        /// and send created object to backend
        coordinator?.goBack()
    }
}

//MARK: - EventCreateDataSourceDelegate -

extension EventCreateViewController: EventCreateDataSourceDelegate {
    
    func tableViewDidSelectSportTypeCell(completion: @escaping (String) -> Void) {
        coordinator?.goToSportTypeListModule(completion: completion)
    }
    
    func tableViewDidSelectSportGroundCell(completion: @escaping (SportGround) -> Void) {
        guard let title = sportTypeTitle else { return }
        
        coordinator?.goToSportGroundSelectionListModule(sportTypeTitle: title, completion: completion)
    }
    
    func tableViewDidSelectDateSelectionCell(
        for sportGround: SportGround?,
        completion: @escaping (String) -> Void
    ) {
        guard  sportGroundTitle != nil, let sportGround = sportGround else { return }
        
        coordinator?.goToDateSelectionModule(sportGround: sportGround, completion: completion)
    }
    
    
    func tableViewSportTypeCell(didSetTitle title: String) {
        self.sportTypeTitle = title
    }
    
    func tableViewSportGroudnCell(didSetTitle title: String) {
        self.sportGroundTitle = title
    }
    
    func tableViewDateSelectionCellDidSetTitle() {
        eventCreateView.bindCreateButton(state: .normal)
    }
}


