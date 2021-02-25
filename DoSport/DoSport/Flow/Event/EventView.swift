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
        $0.registerHeaderFooter(EventTableHeaderView.self)
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }( UITableView(frame: .zero, style: .grouped))

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        messageInputView.delegate = self
        
        addSubviews(tableView, messageInputTopSeparatorView, messageInputView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
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
            $0.bottom.equalTo(messageInputView.snp.top).offset(-1)
        }
        
        messageInputView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(65)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(snp.bottom).offset(-tabBarHeight)
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
    
    func sizeTableHeaderViewToFit() {
        if let headerView = tableView.tableHeaderView as? EventTableHeaderView {
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var newFrame = headerView.frame
            
            if height != newFrame.size.height {
                newFrame.size.height = height
                headerView.frame = newFrame
                
                tableView.tableHeaderView = headerView
            }
        }
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
}

//MARK: - DSTextInputViewDelegate -

extension EventView: DSTextInputViewDelegate {
    
    func sendTextButtonClicked() {
        delegate?.inputViewSendButtonClicked()
    }
}
 
