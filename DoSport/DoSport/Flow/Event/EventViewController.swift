//
//  EventViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit

final class EventViewController: UIViewController {
    
    weak var coordinator: EventCoordinator?
    private let viewModel: EventViewModel
    private lazy var eventView = view as! EventView
    private let eventCollectionManager = EventDataSource()
    
    private let event: Event
    
    private var userToReplyName: String = ""

    // MARK: Init
    
    init(viewModel: EventViewModel, event: Event) {
        self.viewModel = viewModel
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = EventView()
        view.delegate = self
        eventCollectionManager.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""
        
        setupViewModelBindings()
        setupKeyboardNotification()
        
        viewModel.prepareEventData(event: self.event)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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

private extension EventViewController {
    
    func setupViewModelBindings() {
        viewModel.onDidPrepareEventData = { [weak self] event in
            self?.eventCollectionManager.viewModel = event
            self?.updateView()
        }
    }
    
    func updateView() {
        eventView.updateCollectionDataSource(dateSource: self.eventCollectionManager)
    }
    
    func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeybordWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeybordWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}

//MARK: Actions

@objc private extension EventViewController {
    
    func handleKeybordWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = (
                userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            )?.cgRectValue
        else { return }
        
        let value = keyboardFrame.height - CGFloat(UIDevice.getDeviceRelatedTabBarHeight()) // FIXME: костыль
        
        UIView.animate(withDuration: 0.3) {
            self.eventView.transform = CGAffineTransform(translationX: 0, y: -value)
        }
    }
    
    func handleKeybordWillHide() {
        UIViewPropertyAnimator(duration: 0.3, curve: .linear) { [self] in
            eventView.transform = .identity
        }.startAnimation()
    }
}

//MARK: - EventViewDelegate -

extension EventViewController: EventViewDelegate {
    
    func inputViewSendButtonClicked() {
        if eventView.getInputViewText() == userToReplyName {
            eventView.setInputView(text: "")
            eventView.removeInputTextViewFirstResponder()
        } else {
            let _ = eventView.getInputViewText()
            
        }
    }
}

//MARK: - EventDataSourceDelegate -

extension EventViewController: EventDataSourceDelegate {
    
    func collectionViewInviteButtonClicked() {
        
    }
    
    func collectionViewParicipateButtonClicked() {
        
    }
    
    func commentsTableViewReplyButtonClicked(to userName: String?) {
        guard let userName = userName else { return }
        
        self.userToReplyName = userName
        
        eventView.setInputView(text: userName)
        eventView.makeInputTextViewFirstResponder()
    }
    
    func collectionViewSegmentedControlDidChange(index: Int, collectionView: UICollectionView?) {
        guard let collectionView = collectionView else { return }
        
        let indexPath = IndexPath(row: index, section: 0)
        
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        collectionView.isPagingEnabled = true
    }
    
    func chatFrameCollectionView(scrolledTo index: Int, segmentedControl: DSSegmentedControl?) {
        segmentedControl?.setSelectedItemIndex(index)
    }
    
    func collectionViewScrolled(commentsTableView: UITableView?, membersTableView: UITableView?) {
        let indexPath = IndexPath(row: 3, section: 0)

        let cell: CollectionViewToogleCell = self.eventView.getCollectionView().cell(forRowAt: indexPath)
        let cellOriginInRoot = eventView.getCollectionView().convert(cell.frame, to: eventView)
        
        if cellOriginInRoot.maxY <= eventView.getCollectionView().frame.maxY {
            
            eventView.setCollectionView(isScrollingEnabled: false)
            commentsTableView?.isScrollEnabled = true
            membersTableView?.isScrollEnabled = true
        }
    }
    
    func commentsTableViewSrolled(tableView: UITableView?) {
        guard let tableView = tableView else { return }
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        if let cell: TableViewCommentCell = tableView.cellForRow(at: indexPath) as? TableViewCommentCell {

            let cellOriginInRoot = tableView.convert(cell.frame, to: tableView)
            
            if cellOriginInRoot.origin.y > tableView.bounds.origin.y {
                tableView.isScrollEnabled = false
                eventView.setCollectionView(isScrollingEnabled: true)
            }
        }
    }
    
    func membersTableViewSrolled(tableView: UITableView?) {
        guard let tableView = tableView else { return }
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        if let cell: TableViewMemberCell = tableView.cellForRow(at: indexPath) as? TableViewMemberCell {

            let cellOriginInRoot = tableView.convert(cell.frame, to: tableView)
            
            if cellOriginInRoot.origin.y > tableView.bounds.origin.y {
                tableView.isScrollEnabled = false
                eventView.setCollectionView(isScrollingEnabled: true)
            }
        }
    }
}

