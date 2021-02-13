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
        
        eventCollectionManager.onDidTapReplyButton = {
            print(#function)
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
        eventView.messageInputView.textField.resignFirstResponder()
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
