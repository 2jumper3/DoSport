//
//  EventViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit

final class EventViewController: UIViewController {
    
    var coordinator: EventCoordinator?
    private(set) var viewModel: EventViewModel
    
    private lazy var eventView = view as! EventView
    
    var event: Event?
    
    private lazy var eventCollectionManager = EventDataSource()
    
    private var userToReplyName: String = ""

    // MARK: - Init
    
    init(viewModel: EventViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        let view = EventView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""
        
        setupViewModelBindings()
        setupCollectionManagerBindings()
        setupKeyboardNotification()
        
        eventView.messageInputView.messageSendButton.addTarget(
            self,
            action: #selector(handleSendMessageButton),
            for: .touchUpInside
        )
        
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
}

//MARK: - Private methods

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
    
    func setupCollectionManagerBindings() {
        eventCollectionManager.onDidTapInviteButton = { button in
            print(#function)
        }
        
        eventCollectionManager.onDidTapParticipateButton = {
            print(#function)
        }
        
        eventCollectionManager.onDidSelectSegmentedControl = { index, collectionView in
            guard let collectionView = collectionView else { return }
            
            let indexPath = IndexPath(row: index, section: 0)
            
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
            collectionView.isPagingEnabled = true
        }
        
        eventCollectionManager.onDidScroll = { [unowned self] commentsTableV, membersTableV in
            let indexPath = IndexPath(row: 3, section: 0)

            let cell: CollectionViewToogleCell = self.eventView.collectionView.cell(forRowAt: indexPath)
            let cellOriginInRoot = eventView.collectionView.convert(cell.frame, to: eventView)
            
            if cellOriginInRoot.maxY <= eventView.collectionView.frame.maxY {
                
                eventView.collectionView.isScrollEnabled = false
                commentsTableV?.isScrollEnabled = true
                membersTableV?.isScrollEnabled = true
            }
        }
        
        eventCollectionManager.onCommentsDidScroll = { [unowned self] commentsTableV in
            guard let tableV = commentsTableV else { return }
            
            let indexPath = IndexPath(row: 0, section: 0)
            
            if let cell: TableViewCommentCell = tableV.cellForRow(at: indexPath) as? TableViewCommentCell {

                let cellOriginInRoot = tableV.convert(cell.frame, to: tableV)
                
                if cellOriginInRoot.origin.y > tableV.bounds.origin.y {
                    tableV.isScrollEnabled = false
                    eventView.collectionView.isScrollEnabled = true
                }
            }
        }
        
        eventCollectionManager.onMembersDidScroll = { [unowned self] membersTableV in
            guard let tableV = membersTableV else { return }
            
            let indexPath = IndexPath(row: 0, section: 0)
            
            if let cell: TableViewMemberCell = tableV.cellForRow(at: indexPath) as? TableViewMemberCell {

                let cellOriginInRoot = tableV.convert(cell.frame, to: tableV)
                
                if cellOriginInRoot.origin.y > tableV.bounds.origin.y {
                    tableV.isScrollEnabled = false
                    eventView.collectionView.isScrollEnabled = true
                }
            }
        }
        
        eventCollectionManager.onCommentsDidTapReplyButton = { [unowned self] inCell in
//            let indexPath = eventView.collectionView.indexPath(for: inCell)
            let userToReplyName = inCell.memberNameLabel.text ?? ""

            eventView.messageInputView.textField.text = userToReplyName
            eventView.messageInputView.textField.becomeFirstResponder()
        }
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

//MARK: - Actions

@objc
private extension EventViewController {
    
    func handleSendMessageButton() {
        if eventView.messageInputView.textField.text == userToReplyName {
            eventView.messageInputView.textField.text = ""
            eventView.messageInputView.textField.resignFirstResponder()
        } else {
            let text = eventView.messageInputView.textField.text
        }
    }
    
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
