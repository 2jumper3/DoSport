//
//  DSSubscribtionCountView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import UIKit

final class DSSubscribtionCountView: UIView {
    
    private let countLabel: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.text = "0"
        $0.font = Fonts.sfProRegular(size: 24)
        return $0
    }(UILabel())
    
    private let nameLabel: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = Fonts.sfProRegular(size: 14)
        return $0
    }(UILabel())

    
    //MARK: Init
    
    init(name: String = "", count: String = "") {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.countLabel.text = count
        self.nameLabel.text = name
        
        addSubviews(countLabel, nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        countLabel.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: bounds.height * 0.75
        )
        
        nameLabel.frame = CGRect(
            x: 0,
            y: countLabel.frame.maxY+3,
            width: bounds.width,
            height: bounds.height * 0.75
        )
    }
}
