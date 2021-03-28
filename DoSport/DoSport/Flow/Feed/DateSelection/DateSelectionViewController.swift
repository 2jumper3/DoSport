//
//  DateSelectionViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit
import FSCalendar

final class DateSelectionViewController: UIViewController, UIGestureRecognizerDelegate {
    
    weak var coordinator: DateSelectionCoordinator?
    private let viewModel: DateSelectionViewModel
    private lazy var dateSelectionView = view as! DateSelectionView
    private let collectionManager = DateSelectionDataSource()
    
    private let completion: (String) -> Void
    private let sportGround: SportGround
    
    private var selectedDate: Date?
    private var calendarSelectedDate: Date?
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
        /// go back by swipe
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        collectionManager.delegate = self
        dateSelectionView.setCalendarDelegate(self)
        
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
}

//MARK: Private API

private extension DateSelectionViewController {
    
    func setupNavBar() {
        title = Texts.DateSelection.date
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: Fonts.sfProRegular(size: 18),
            NSAttributedString.Key.foregroundColor: Colors.mainBlue
        ]
        
        let button = UIButton.makeBarButton()
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
        /// clear notAvailable & selected hours of previos date
        notAvailableHours.removeAll()
        selectedHours.removeAll()
        
        /// clear selected hours of previous date
        collectionManager.selectedHours.removeAll()
        updateView()
        
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

//MARK: - FSCalendarDelegate -

extension DateSelectionViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if date.removeTimeStamp?.compare(Date().removeTimeStamp!) == .orderedAscending {
            /// Past date was selected ----
            /// Selection colour will not change from default colour so user will understand that past days are not
            ///  available to be selected
            calendar.appearance.selectionColor = .clear
            calendar.appearance.titleSelectionColor = Colors.dirtyBlue
            return
        }
        /// ELSE. Upcomming date or current date  was selected
        
        let currentMonth = Calendar.current(.month, for: calendar.currentPage)
        let selectedDateMonth = Calendar.current(.month, for: date)
        
        /// If user selects date out of current month then show him selected date's month
        if selectedDateMonth != currentMonth {
            calendar.setCurrentPage(date, animated: true)
            self.calendarSelectedDate = date
            self.checkAvailableHoursFor(selected: date)
            return
        }
        
        /// If user selected day and selects it again we should deselect selected date. And set it nil after deselection
        if let selectedDate = calendarSelectedDate, selectedDate == date {
            calendar.deselect(date)
            self.calendarSelectedDate = nil
            
            /// And if date is selected then send to VC selected date,
            /// otherwise send to VC current date
            self.checkAvailableHoursFor(selected:  Date())
        } else {
            if calendarSelectedDate != nil {
                calendar.deselect(calendarSelectedDate!)
                self.calendarSelectedDate = nil
            }
            
            self.calendarSelectedDate = date
            self.checkAvailableHoursFor(selected: date)
        }
        
        calendar.appearance.selectionColor = Colors.lightBlue
        calendar.appearance.titleSelectionColor = .white
    }
}

//MARK: - FSCalendarDelegateAppearance -

extension DateSelectionViewController: FSCalendarDelegateAppearance {
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        /// In order to reload date colours of previous month and current
        calendar.reloadData()
    }
    
    /// Setup calendarView's each date title colour by `past or future months` / `current month ` / `current day`
    func calendar(
        _ calendar: FSCalendar,
        appearance: FSCalendarAppearance,
        titleDefaultColorFor date: Date
    ) -> UIColor? {
        if date.removeTimeStamp?.compare(Date().removeTimeStamp!) == .orderedAscending {
            /// Set past dates color
            
            return Colors.dirtyBlue
        } else if date.removeTimeStamp!.compare(Date().removeTimeStamp!) == .orderedDescending {
            /// Set upcomming dates
            
            let currentPage = dateSelectionView.getCalendarCurrentPage()
            
            let month = Calendar.current(.month, for: date),
                year = Calendar.current(.year, for: date)
            let currnentMonth = Calendar.current(.month, for: currentPage),
                currnentYear = Calendar.current(.year, for: currentPage)
            
            /// Set only current month's dates color to white,  otherwise set dirtyBlue
            if (month == currnentMonth) && (year == currnentYear) {
                return .white
            } else {
                return Colors.dirtyBlue
            }
        } else {
            /// Set current date color
            return .white
        }
    }
}

