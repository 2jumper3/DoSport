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
    
    private var tableManager = EventCreateDataSource()
    
    private var cellStateCounter: Int = 0 {
        didSet {
            handleCellStateCounterChange()
        }
    }
    
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
        setupButtonTargets()
        setupTableManagerBindings()
        
        eventCreateView.updateTableDataSource(dataSource: self.tableManager)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: - Private methods

private extension EventCreateViewController {
    
    func handleCellStateCounterChange() {
        if cellStateCounter == 3 {
            eventCreateView.createButton.bind(state: .normal)
        } else {
            eventCreateView.createButton.bind(state: .disabled)
        }
    }
    
    func setupNavBar() {
        title = Texts.EventCreate.navTitle
        
        navigationItem.setHidesBackButton(true, animated: true)
        
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
    
    func setupButtonTargets() {
        eventCreateView.createButton.addTarget(self, action: #selector(handleEventCreateButton), for: .touchUpInside)
    }
    
    func setupTableManagerBindings() {
        tableManager.onDidTapSportTypeCell = { [weak self] cell in
            self?.coordinator?.goToSportTypeListModule(with: cell)
        }
        
        tableManager.onDidTapPlaygroundCell = { [weak self] cell in
            self?.coordinator?.goToPlaygroundListModule(with: cell)
        }
        
        tableManager.onDidTapDateCell = { [weak self] cell in
            self?.coordinator?.goToDateSelectionModule(with: cell)
        }
        
        tableManager.onDidTapCheckboxButton = { button in
            button.bind()
        }
        
        tableManager.onDidTapDoneButton = { textView in
            textView.resignFirstResponder()
        }
        
        tableManager.onSportTypeCellDidChangeState = { [unowned self] state in
            if state == .dataSelected {
                self.cellStateCounter += 1
            }
        }
        
        tableManager.onPlaygroundCellDidChangeState = { [unowned self] state in
            if state == .dataSelected {
                self.cellStateCounter += 1
            }
        }
        
        tableManager.onDateSelecteCellDidChangeState = { [unowned self] state in
            if state == .dataSelected {
                self.cellStateCounter += 1
            }
        }
    }
}

//MARK: - Actions

@objc
private extension EventCreateViewController {
    
    func handleCancelButton() {
        coordinator?.goBack()
    }
    
    func handleEventCreateButton(_ button: CommonButton) {
        print(#function)
    }
}


