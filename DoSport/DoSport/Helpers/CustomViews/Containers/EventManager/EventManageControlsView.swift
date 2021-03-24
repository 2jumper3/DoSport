//
//  EventManageControlsView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import UIKit

protocol EventControlsViewDelegate: class {
    func inviteButtonClicked()
//    func closeButtonClicked()
    func editButtonClicked()
    func deleteButtonClicked()
    func cancelButtonClicked()
}

final class EventManageControlsView: UIView {
    
    weak var delegate: EventControlsViewDelegate?
    
    //MARK: Outlets
    
    private let containerView: UIView = {
        $0.layer.cornerRadius = 12
        $0.backgroundColor = Colors.mainBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    // FIXME: able to move separator into DSEventControlButton class to meet DRY.
    private let inviteSeparator = DSSeparatorView(color: Colors.dirtyBlue)
    private let editSeparator = DSSeparatorView(color: Colors.dirtyBlue)
    private let closeSeparator = DSSeparatorView(color: Colors.dirtyBlue)
    
    private lazy var inviteButton = DSEventControlButton(img: Icons.UserMain.share, txt: Texts.UserMain.invite)
    private lazy var deleteButton = DSEventControlButton(img: Icons.UserMain.delete, txt: Texts.UserMain.delete)
    private lazy var editButton = DSEventControlButton(img: Icons.UserMain.edit, txt: Texts.UserMain.edit)
//    private lazy var closeButton = DSEventControlButton(img: Icons.UserMain.unlock, txt: Texts.UserMain.close)
    
    private lazy var cancelButton: UIButton = {
        $0.backgroundColor = Colors.mainBlue
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle(Texts.Feed.cancel, for: .normal)
        $0.setTitleColor(.gray, for: .highlighted)
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(handleCancelButton))
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        let inviteTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleInviteButton))
        let deleteTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDeleteButton))
        let editTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleEditButton))
//        let closeTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCloseButton))
        
        inviteButton.addGestureRecognizer(inviteTapGesture)
        deleteButton.addGestureRecognizer(deleteTapGesture)
        editButton.addGestureRecognizer(editTapGesture)
//        closeButton.addGestureRecognizer(closeTapGesture)
        
        containerView.addSubviews(
            inviteButton,
            inviteSeparator,
            deleteButton,
            editButton,
//            closeButton,
            editSeparator
//            closeSeparator
        )
        
        addSubviews(containerView, cancelButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.92)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(150)
            $0.bottom.equalTo(cancelButton.snp.top).offset(-12)
        }
        
        inviteButton.snp.makeConstraints {
            $0.centerX.width.top.equalTo(containerView)
            $0.height.equalTo(containerView.snp.height).multipliedBy(0.24)
            $0.width.equalTo(containerView.snp.width).multipliedBy(0.9)
        }
        
        inviteSeparator.snp.makeConstraints {
            $0.top.equalTo(inviteButton.snp.bottom)
            $0.centerX.width.equalToSuperview()
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(inviteButton.snp.bottom)
            $0.centerX.width.equalTo(containerView)
            $0.height.equalTo(containerView.snp.height).multipliedBy(0.24)
            $0.width.equalTo(containerView.snp.width).multipliedBy(0.9)
        }
        
        editSeparator.snp.makeConstraints {
            $0.top.equalTo(editButton.snp.bottom)
            $0.centerX.width.equalToSuperview()
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
        
//        closeButton.snp.makeConstraints {
//            $0.top.equalTo(editButton.snp.bottom)
//            $0.centerX.width.equalTo(containerView)
//            $0.height.equalTo(containerView.snp.height).multipliedBy(0.24)
//            $0.width.equalTo(containerView.snp.width).multipliedBy(0.9)
//        }
//
//        closeSeparator.snp.makeConstraints {
//            $0.top.equalTo(closeButton.snp.bottom)
//            $0.centerX.width.equalToSuperview()
//            $0.height.equalTo(1)
//            $0.width.equalToSuperview()
//        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(editButton.snp.bottom)
            $0.centerX.width.equalTo(containerView)
            $0.height.equalTo(containerView.snp.height).multipliedBy(0.24)
            $0.width.equalTo(containerView.snp.width).multipliedBy(0.9)
        }
        
        let cancelButtonBottom = UIDevice.hasBang ? 30 : 15
        cancelButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.92)
            $0.bottom.equalToSuperview().offset(-cancelButtonBottom)
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
        }
    }
}

//MARK: Actions

@objc private extension EventManageControlsView {
    
    func handleInviteButton() {
        delegate?.inviteButtonClicked()
    }
    
    func handleEditButton() {
        delegate?.editButtonClicked()
    }
    
    func handleDeleteButton() {
        delegate?.deleteButtonClicked()
    }
    
//    func handleCloseButton() {
//        delegate?.closeButtonClicked()
//    }
    
    func handleCancelButton() {
        delegate?.cancelButtonClicked()
    }
}
