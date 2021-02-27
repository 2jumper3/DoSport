//
//  EventTableChatHeaderView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 24/02/2021.
//

import UIKit

final class EventTableChatHeaderView: UITableViewHeaderFooterView {
    
    var onSegmentedControlChanged: ((Int) -> Void)?
    
    var firstIndexText: String = "" {
        didSet {
            segmentedControl.setTitle(self.firstIndexText, forItemAt: 0)
        }
    }
    
    var secondIndexText: String = "" {
        didSet {
            segmentedControl.setTitle( self.secondIndexText, forItemAt: 1)
        }
    }
    
    var selectedItemIndex: Int = 0 {
        didSet {
            segmentedControl.setSelectedItemIndex(selectedItemIndex)
        }
    }
    
    //MARK: Outlets
    
    private lazy var segmentedControl: DSSegmentedControl = {
        let items = ["", ""]
        let segmentedControl = DSSegmentedControl(titles: items)
        segmentedControl.setSelectedItemIndex(self.selectedItemIndex)
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
    
    func setSegmentedControl(text: String, for index: Int) {
        segmentedControl.setTitle(text, forItemAt: index)
    }
}

//MARK: - DSSegmentedControlDelegate -

extension EventTableChatHeaderView: DSSegmentedControlDelegate {
    
    func didSelectItem(at index: Int) {
        onSegmentedControlChanged?(index)
    }
}
