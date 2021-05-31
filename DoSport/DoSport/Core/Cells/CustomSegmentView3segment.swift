//
//  CustomSegmentView3segment.swift
//  DoSport
//
//  Created by Sergey on 28.05.2021.
//

import UIKit

final class CustomSegmentView3segment: UICollectionReusableView {
    
    var onSegmentedControlChanged: ((Int) -> Void)?
    
    //MARK: Outlets
    
    private lazy var segmentedControl: DSSegmentedControl = {
        let items = ["", "", ""]
        let segmentedControl = DSSegmentedControl(titles: items)
        segmentedControl.setSelectedItemIndex(0)
        segmentedControl.setTitleStyle(fontSize: 16)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        segmentedControl.delegate = self
        
        backgroundColor = Colors.darkBlue
        addSubviews(segmentedControl)
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

extension CustomSegmentView3segment {
    
    func getSegmentedControl() -> DSSegmentedControl {
        return segmentedControl
    }
    
    func setSegmentedControl(text: String, for index: Int) {
        segmentedControl.setTitle(text, forItemAt: index)
    }
}

//MARK: - DSSegmentedControlDelegate -

extension CustomSegmentView3segment: DSSegmentedControlDelegate {
    
    func didSelectItem(at index: Int) {
        onSegmentedControlChanged?(index)
    }
}
