//
//  DSCommonButton.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//
import UIKit

enum DSCommonButtonState {
    case disabled, normal
}

final class DSCommonButton: UIButton {
    
    private var buttonState: DSCommonButtonState = .normal {
        didSet {
            handleStateChange()
        }
    }
    
    //MARK: Init
    
    init(
        title: String = "",
        state: DSCommonButtonState = .normal,
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
extension DSCommonButton {
    
    func bind(state: DSCommonButtonState) {
        buttonState = state
    }
    
    func isHidden(_ value: Bool) {
        self.isHidden = value
    }
    
    func getState() -> DSCommonButtonState {
        return buttonState
    }
}

//MARK: Private API
private extension DSCommonButton {
    
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
