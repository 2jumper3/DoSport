//
//  DSCheckboxButton.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//
import UIKit

final class DSCheckboxButton: UIButton {
    
    enum State {
        case selected, notSelected
    }
    
    private var buttonState: State = .notSelected {
        didSet {
            handleStateChange()
        }
    }
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = Colors.dirtyBlue.cgColor
        backgroundColor = Colors.darkBlue
        setTitleColor(.gray, for: .highlighted)
        setImage(nil, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Public methods
extension DSCheckboxButton {
    
    func bind() {
        switch buttonState {
        case .selected:
            buttonState = .notSelected
        case .notSelected:
            buttonState = .selected
        }
    }
    
    func getState() -> State {
        return buttonState
    }
}

//MARK: - Private methods
private extension DSCheckboxButton {
    
    func handleStateChange() {
        switch buttonState {
        case .selected:
            UIViewPropertyAnimator(duration: 0.1, curve: .linear) { [self] in
                layer.borderColor = Colors.lightBlue.cgColor
                backgroundColor = Colors.lightBlue
                setImage(Icons.EventCreate.checkMark, for: .normal)
            }.startAnimation()
            
        case .notSelected:
            UIViewPropertyAnimator(duration: 0.1, curve: .linear) { [self] in
                layer.borderColor = Colors.dirtyBlue.cgColor
                backgroundColor = Colors.darkBlue
                setImage(nil, for: .normal)
            }.startAnimation()
        }
    }
}
