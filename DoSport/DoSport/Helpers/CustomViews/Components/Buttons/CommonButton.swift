//
//  CommonButton.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

enum CommonButtonState {
    case disabled, normal
}

final class CommonButton: UIButton {
    
    private var buttonState: CommonButtonState = .normal {
        didSet {
            handleStateChange()
        }
    }
    
    //MARK: Init
    
    init(
        title: String = "",
        state: CommonButtonState = .normal,
        isHidden: Bool = false
    ) {
        super.init(frame: .zero)
        
        layer.cornerRadius = 8
        self.isHidden = isHidden
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray, for: .highlighted)
        translatesAutoresizingMaskIntoConstraints = false
        bind(state: state)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Public API

extension CommonButton {
    
    func bind(state: CommonButtonState) {
        buttonState = state
    }
    
    func isHidden(_ value: Bool) {
        self.isHidden = value
    }
    
    func getState() -> CommonButtonState {
        return buttonState
    }
}

//MARK: Private API

private extension CommonButton {
    
    func handleStateChange() {
        switch buttonState {
        case .disabled:
            isUserInteractionEnabled = false
            backgroundColor = Colors.dirtyBlue
        case .normal:
            isUserInteractionEnabled = true
            backgroundColor = Colors.lightBlue
        }
    }
}
