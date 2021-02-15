//
//  CollectionViewToogleCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit
import SnapKit

final class CollectionViewToogleCell: UICollectionViewCell {
    
    var messages: Int = 0 {
        didSet {
            segmentedControl.setTitle(
                "\(self.messages) Комментарии",
                forSegmentAt: 0
            )
        }
    }
    
    var members: Int = 0 {
        didSet {
            segmentedControl.setTitle(
                "\(self.members) Участники",
                forSegmentAt: 1
            )
        }
    }
    
    private(set) lazy var segmentedControl: UISegmentedControl = {
        let items = ["", ""]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.font: Fonts.sfProRegular(size: 16)],
            for: .normal
        )
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
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
