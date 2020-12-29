//
//  DSBarBackButton.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 29/12/2020.
//

import UIKit

final class DSBarBackButton: UIButton {
    
    init(target: Any?, action: Selector) {
        super.init(frame: .zero)
        setImage(Icons.CountryList.backButton, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleToFill
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
