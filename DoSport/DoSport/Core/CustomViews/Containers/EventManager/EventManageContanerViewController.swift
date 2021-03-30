//
//  EventManageContanerViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import UIKit

protocol EventManageContanerViewControllerDelegate: class {
    func eventManageCancelButtonClicked()
    func touchBegan()
    func inviteButtonClicked()
//    func closeButtonClicked()
    func editButtonClicked()
    func deleteButtonClicked()
}

final class EventManageContanerViewController: UIViewController {
    
    weak var delegate: EventManageContanerViewControllerDelegate?
    
    lazy var inviteFriendChildView = self.view as! EventManageControlsView
    
    //MARK: Life cycle
    
    override func loadView() {
        let view = EventManageControlsView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        delegate?.touchBegan()
    }
}

//MARK: - EventControlsViewDelegate -

extension EventManageContanerViewController: EventControlsViewDelegate {
    
    func inviteButtonClicked() {
        delegate?.inviteButtonClicked()
    }
    
    func editButtonClicked() {
        delegate?.editButtonClicked()
    }
    
    func deleteButtonClicked() {
        delegate?.deleteButtonClicked()
    }
    
    func cancelButtonClicked() {
        delegate?.eventManageCancelButtonClicked()
    }
}
