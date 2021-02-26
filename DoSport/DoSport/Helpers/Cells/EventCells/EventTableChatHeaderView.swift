//
//  EventTableChatHeaderView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 24/02/2021.
//

import UIKit

final class EventTableChatHeaderView: UITableViewHeaderFooterView {
    
    var onSegmentedControlChanged: ((Int) -> Void)?
    
    var messagesCount: Int = 0 {
        didSet {
            segmentedControl.setTitle("\(self.messagesCount) Комментариев", forItemAt: 0)
        }
    }
    
    var membersCount: Int = 0 {
        didSet {
            segmentedControl.setTitle( "\(self.membersCount) Участников", forItemAt: 1)
        }
    }
    
    //MARK: Outlets
    
    private lazy var segmentedControl: DSSegmentedControl = {
        let items = ["", ""]
        let segmentedControl = DSSegmentedControl(titles: items)
        segmentedControl.setSelectedItemIndex(0)
        segmentedControl.setTitleStyle(fontSize: 16)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    //MARK: Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        segmentedControl.delegate = self
        
        contentView.backgroundColor = Colors.darkBlue
        contentView.addSubviews(segmentedControl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        segmentedControl.snp.makeConstraints {
            $0.top.centerX.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
        }
    }
}

//MARK: Public API

extension EventTableChatHeaderView {
    
    func getSegmentedControl() -> DSSegmentedControl {
        return segmentedControl
    }
}

//MARK: - DSSegmentedControlDelegate -

extension EventTableChatHeaderView: DSSegmentedControlDelegate {
    
    func didSelectItem(at index: Int) {
        onSegmentedControlChanged?(index)
    }
}
