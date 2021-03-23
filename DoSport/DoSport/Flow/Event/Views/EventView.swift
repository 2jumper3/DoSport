//
//  EventView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit

protocol EventViewDelegate: class {
    func inputViewSendButtonClicked()
}
    
final class EventView: UIView {
    
    weak var delegate: EventViewDelegate?
    
    private let tabBarHeight = UIDevice.getDeviceRelatedTabBarHeight()
    
    //MARK: Outlets

    private let messageInputTopSeparatorView = DSSeparatorView()
    
    private let messageInputView = DSMessageInputView()
    
    private let tableView: UITableView = {
        $0.backgroundColor = Colors.darkBlue
        $0.registerClass(TableViewCommentCell.self)
        $0.registerClass(TableViewMemberCell.self)
        $0.registerClass(EventCardTableCell.self)
        $0.registerHeaderFooter(EventTableChatHeaderView.self)
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView(frame: .zero, style: .plain))
    
    private let eventVisibilityChangePopupView = EventVisibilityChangePopupView(isClosedType: true)
    
    private let visualEffect: UIVisualEffectView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.effect = UIBlurEffect(style: .systemMaterialDark)
        $0.alpha  = 0.0
        return $0
    }(UIVisualEffectView())

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        messageInputView.delegate = self
        
        addSubviews(tableView, messageInputTopSeparatorView, messageInputView, visualEffect, eventVisibilityChangePopupView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        visualEffect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.93)
            $0.top.equalTo(safeAreaInsets.top)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(messageInputView.snp.top).offset(-2)
        }
        
        messageInputTopSeparatorView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(messageInputView.snp.top)
        }
        
        messageInputView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(65)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(snp.bottom).offset(-tabBarHeight)
        }
        
        eventVisibilityChangePopupView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(150)
        }
    }
}

//MARK: Public API

extension EventView {
    
    func updateCollectionDataSource(dateSource: (UITableViewDelegate & UITableViewDataSource)) {
        tableView.delegate = dateSource
        tableView.dataSource = dateSource
        tableView.reloadData()
        layoutIfNeeded()
    }
    
    func getInputViewText() -> String {
        return messageInputView.getInputText()
    }
    
    func setInputView(text: String) {
        messageInputView.setInput(text: text)
    }
    
    func makeInputTextViewFirstResponder() {
        messageInputView.makeTextFieldFirstResponder()
    }
    
    func removeInputTextViewFirstResponder() {
        messageInputView.removeTextFieldFirstResponder()
    }
    
    func showEventVisibilityChangePopupView() {
        UIViewPropertyAnimator(duration: 0.2, curve: .linear) { [unowned self] in
            eventVisibilityChangePopupView.alpha = 1.0
            visualEffect.alpha = 1.0
        }.startAnimation()
    }
    
    func hideEventVisibilityChangePopupView() {
        UIViewPropertyAnimator(duration: 0.2, curve: .linear) { [unowned self] in
            eventVisibilityChangePopupView.alpha = 0.0
            visualEffect.alpha = 0.0
        }.startAnimation()
    }
}

//MARK: - DSTextInputViewDelegate -

extension EventView: DSTextInputViewDelegate {
    
    func sendTextButtonClicked() {
        delegate?.inputViewSendButtonClicked()
    }
}
 
