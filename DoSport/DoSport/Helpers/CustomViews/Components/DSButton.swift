//
//  DSButton.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/01/2021.
//

import UIKit

final class DSButton: UIButton {
    
    enum State {
        case normal, seleted
    }
    
    var buttonState: State = .normal {
        didSet {
            handleButtonDidSelected()
        }
    }
    
    //MARK: - Init
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = Colors.dirtyBlue.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        setTitleColor(.gray, for: .highlighted)
        titleLabel?.font = Fonts.sfProRegular(size: 16)
        titleLabel?.textColor = .white
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Public methods

extension DSButton {
    func bind(state: State) {
        buttonState = state
    }
}

//MARK: - Private methods

private extension DSButton {
    func handleButtonDidSelected() {
        switch buttonState {
        case .normal:
            backgroundColor = Colors.darkBlue
        case .seleted:
            backgroundColor = Colors.lightBlue
        }
    }
}
