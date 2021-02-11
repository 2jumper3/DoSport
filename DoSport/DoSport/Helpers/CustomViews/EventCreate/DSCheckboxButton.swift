//
//  DSCheckboxButton.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

final class DSCheckboxButton: UIButton {
    
    private enum State {
        case selected, notSelected
    }
    
    private var buttonState: State = .notSelected {
        didSet {
            
        }
    }
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = Colors.lightBlue
        setImage(Icons.EventCreate.checkMark, for: .normal)
        setTitleColor(.gray, for: .highlighted)
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Public methods

//MARK: - Private methods
