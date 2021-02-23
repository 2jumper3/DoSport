//
//  DateSelectionViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

final class DateSelectionViewController: UIViewController {
    
    weak var coordinator: DateSelectionCoordinator?
    private let viewModel: DateSelectionViewModel
    private lazy var dateSelectionView = view as! DateSelectionView
    private let collectionManager = DateSelectionDataSource()
    
    private let completion: (String) -> Void
    private let sportGround: SportGround
    
    private var selectedDate: Date?
    private var selectedHours: [String] = []
    private var notAvailableHours: [String] = []
    
    private var finalDateString: String {
        guard let index = selectedHours.first?.firstIndex(of: "-"),
              let startHour = selectedHours.first?.prefix(upTo: index),
              let range = selectedHours.last?.range(of: "-"),
              let endHour = selectedHours.last?[range.upperBound...],
              let selectedDate = selectedDate else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
        
        return "\(formattedDate) с \(startHour) до \(endHour)"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(
        viewModel: DateSelectionViewModel,
        sportGround: SportGround,
        completion: @escaping (String) -> Void
    ) {
        self.viewModel = viewModel
        self.completion = completion
        self.sportGround = sportGround
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = DateSelectionView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionManager.delegate = self
        
        setupNavBar()
        setupViewModelBindings()
        
        viewModel.prepareData()
        
        let todayDate = Date()
        selectedDate = todayDate
        checkAvailableHoursFor(selected: todayDate)
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

private extension DateSelectionViewController {
    
    func setupNavBar() {
        title = Texts.DateSelection.date
        
        let button = UIButton(type: .system)
        button.setImage(Icons.SportTypeList.backButton, for: .normal)
        button.tintColor = Colors.mainBlue
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func setupViewModelBindings() {
        viewModel.onDidPrepareDefaultHours = { [weak self] hours in
            guard let self = self else { return }

            self.collectionManager.defaultHours = hours
            self.updateView()
        }
    }
    
    func updateView() {
        self.dateSelectionView.udpateTableDataSource(dataSource: collectionManager)
    }
    
    func checkAvailableHoursFor(selected date: Date) {
        /// clear notAvailable hours of previos date
        notAvailableHours.removeAll()
        
        /// clear selected hours of previous date
        collectionManager.selectedHours.removeAll()
        
        self.selectedDate = date
        
        sportGround.events?.forEach { event in
            guard let eventDate = event.eventDate,
                  let eventStartDate = event.eventStartTime,
                  let eventEndDate = event.eventEndTime
            else {
                return
            }
            
            let calendar = Calendar.current
            let selectedDay = calendar.component(.day, from: date)
            let selectedMonth = calendar.component(.month, from: date)
            let selectedYear = calendar.component(.year, from: date)
             
            let eventDay = calendar.component(.day, from: eventDate)
            let eventMonth = calendar.component(.month, from: eventDate)
            let eventYear = calendar.component(.year, from: eventDate)
            
            if (selectedDay == eventDay)
                && (selectedMonth == eventMonth)
                && (selectedYear == eventYear) {
                
                let eventStartHour = calendar.component(.hour, from: eventStartDate)
                let eventEndHour = calendar.component(.hour, from: eventEndDate)
                let eventHourString = "\(eventStartHour):00-\(eventEndHour):00"
                self.notAvailableHours.append(eventHourString)
            }
        }
        
        collectionManager.notAvailableHours = self.notAvailableHours
        updateView()
    }
}

//MARK: Actions

@objc private extension DateSelectionViewController {
    
    func handleBackButton() {
        coordinator?.goBack()
    }
}

//MARK: - DateSelectionViewDelegate -

extension DateSelectionViewController: DateSelectionViewDelegate {

    func calendarView(didSelect date: Date) {
        checkAvailableHoursFor(selected: date)
    }
    
    func saveButtonClicked() {
        completion(finalDateString)
        coordinator?.goBack()
    }
}

//MARK: - DateSelectionDataSourceDelegate -

extension DateSelectionViewController: DateSelectionDataSourceDelegate {
    
    func collectionView(didSelect hour: String) {
        self.selectedHours.append(hour)
        print(selectedHours)
        
        if dateSelectionView.getSaveButtonState() == .disabled {
            dateSelectionView.bindSaveButton(state: .normal)
        }
    }
    
    func collectionView(didCancelSelection hour: String) {
        for (i, existingHour) in selectedHours.enumerated() {
            if existingHour == hour {
                self.selectedHours.remove(at: i)
            }
        }
        print(selectedHours)
        if dateSelectionView.getSaveButtonState() == .normal, selectedHours.count == 0 {
            dateSelectionView.bindSaveButton(state: .disabled)
        }
    }
    
    func collectionViewAfterClearAll(didSelect hour: String) {
        selectedHours.removeAll()
        selectedHours.append(hour)
    }
}

