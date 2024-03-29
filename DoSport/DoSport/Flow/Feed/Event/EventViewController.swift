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
    private lazy var eventCollectionManager = EventDataSource(isCurrentUserOrganisedEvent: self.isCurrentUserOrganisedEvent)
    
    private let event: DSModels.Event.EventView
    
    private var isEventVisibilityPopupShown: Bool = false
    
    private var userToReplyName: String = ""
    
    private var eventInviteContainer: EventInviteViewController?
    
    private let isCurrentUserOrganisedEvent: Bool
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(viewModel: EventViewModel, event: DSModels.Event.EventView, isCurrentUserOrganisedEvent: Bool) {
        self.viewModel = viewModel
        self.event = event
        self.isCurrentUserOrganisedEvent = isCurrentUserOrganisedEvent
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
        navigationController?.navigationBar.tintColor = Colors.mainBlue
        
        setupKeyboardNotification()
        
        self.eventCollectionManager.viewModel = event
        self.updateView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setup(&eventInviteContainer)
        eventInviteContainer?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.removeDependency(coordinator)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if isEventVisibilityPopupShown {
            eventView.hideEventVisibilityChangePopupView()
        }
    }
    
    deinit {
        self.removeKeyboardNotification()
    }
}

//MARK: Private API

private extension EventViewController {
    
    func updateView() {
        eventView.updateCollectionDataSource(dateSource: self.eventCollectionManager)
    }
    // TODO: move it to extension
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
    // TODO: move it to extension
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func presentUIActivityController() {
        guard let eventId = event.eventID else { return }
        let url = "dosport://feed/event/" + String(eventId)
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityController, animated: true)
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
    
    func tableViewInviteButtonClicked() {
        eventInviteContainer?.setupKeyboardNotification()
        present(eventInviteContainer)
    }
    
    func tableViewParicipateButtonClicked() {
        
    }
    
    func tableViewEventVisibilityChangeButtonClicked() {
        if isEventVisibilityPopupShown {
            eventView.showEventVisibilityChangePopupView()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [unowned self] in
                eventView.hideEventVisibilityChangePopupView()
            }
            
            isEventVisibilityPopupShown = !isEventVisibilityPopupShown
            return
        }
        
        isEventVisibilityPopupShown = !isEventVisibilityPopupShown
    }
    
    func commentReplyButtonClicked(to userName: String?) {
        guard let userName = userName else { return }
        
        self.userToReplyName = userName
        
        eventView.setInputView(text: userName)
        eventView.makeInputTextViewFirstResponder()
    }
    
    func tableViewNeedsReloadData() {
        eventView.updateCollectionDataSource(dateSource: eventCollectionManager)
    }
}

//MARK: - EventInviteViewControllerDelegate -

extension EventViewController: EventInviteViewControllerDelegate {
    
    func cancelButtonClicked() {
        dismiss(eventInviteContainer, from: eventView)
    }
    
    func shareButtonClicked() {
        print("shareButtonClicked")
    }
}

