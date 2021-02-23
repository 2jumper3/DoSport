//
//  CollectionViewToogleCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit

final class CollectionViewToogleCell: UICollectionViewCell {
    
    var onSegmentedControlChanged: ((Int) -> Void)?
    
    var messages: Int = 0 {
        didSet {
            segmentedControl.setTitle("\(self.messages) Комментариев", forItemAt: 0)
        }
    }
    
    var members: Int = 0 {
        didSet {
            segmentedControl.setTitle( "\(self.members) Участников", forItemAt: 1)
        }
    }
    
    //MARK: Outlets
    
    private lazy var segmentedControl: DSSegmentedControl = {
        let items = ["", ""]
        let segmentedControl = DSSegmentedControl(titles: items)
        segmentedControl.setSelectedItemIndex(0)
        
        let size: CGFloat = UIDevice.deviceSize == .small ? 14.5 : 16.5
            
        segmentedControl.setTitleStyle(fontSize: size)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        segmentedControl.delegate = self
        backgroundColor = Colors.darkBlue
        contentView.addSubview(segmentedControl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        segmentedControl.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

//MARK: Public API

extension CollectionViewToogleCell {
    
    func getSegmentedControl() -> DSSegmentedControl {
        return segmentedControl
    }
}

//MARK: - DSSegmentedControlDelegate -

extension CollectionViewToogleCell: DSSegmentedControlDelegate {
    
    func didSelectItem(at index: Int) {
        onSegmentedControlChanged?(index)
    }
}
