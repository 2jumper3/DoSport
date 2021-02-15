//
//  EventCreateViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit
import RangeSeekSlider

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
            NSAttributedString.Key.foregroundColor: Colors.mainBlue
        ]
        
        let button = UIButton(type: .system)
        button.setImage(Icons.EventCreate.cancel, for: .normal)
        button.tintColor = Colors.mainBlue
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
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
            var superview = button.superview
            
            while let view = superview, !(view is MembersCountCell) {
                superview = view.superview
            }
            
            guard let cell = superview as? MembersCountCell else {
                debugPrint("button is not contained in a MembersCountCell")
                return
            }
            
            button.bind()
            
            switch button.getState() {
            case .notSelected:
                cell.rangeSlide.bind(state: .enabled)
            case .selected:
                cell.rangeSlide.bind(state: .disabled)
            }
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
        
        tableManager.onSliderDidChangeValues = { minV, maxV, minVLabel, maxVLabel in
            minVLabel.text = "от \(Int(minV))"
            maxVLabel.text = "до \(Int(maxV))"
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


