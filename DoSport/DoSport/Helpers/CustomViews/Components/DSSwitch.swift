//
//  DSSwitch.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit.UISwitch

// Reusable UISwitch
final class DSSwitch: UISwitch {
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        tintColor = Colors.dirtyBlue
        onTintColor = Colors.lightBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
