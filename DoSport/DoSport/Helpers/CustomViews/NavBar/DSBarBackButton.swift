//
//  DSBarBackButton.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 29/12/2020.
//

import UIKit

final class DSBarBackButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setImage(Icons.CountryList.backButton, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleToFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
