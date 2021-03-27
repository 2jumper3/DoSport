//
//  DSSeparatorView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

/// Simple separatorView class
// TODO: avoid using entire UIView object for just drawing a line.
final class DSSeparatorView: UIView {
    
    init(color: UIColor = Colors.dirtyBlue) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
