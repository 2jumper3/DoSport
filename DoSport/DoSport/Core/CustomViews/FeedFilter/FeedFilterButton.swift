//
//  FeedFilterButton.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit

final class FeedFilterButton: UIButton {
    
    enum State {
        case selected, notSelected
    }
    
    private var buttonState: State = .notSelected {
        didSet {
            setState()
        }
    }
    
    //MARK: - Init
    
    init(title: String = "", state: State) {
        super.init(frame: .zero)
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = Colors.dirtyBlue.cgColor
        titleLabel?.font = Fonts.sfProRegular(size: 16)
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

//MARK: - Public methods

extension FeedFilterButton {
    
    func bind() {
        switch buttonState {
        case .notSelected:
            buttonState = .selected
        case .selected:
            buttonState = .notSelected
        }
    }
    
    func bind(state: State) {
        buttonState = state
    }
    
    func getState() -> State {
        return buttonState
    }
}

//MARK: - Private methods

private extension FeedFilterButton {
    
    func setState() {
        switch buttonState {
        case .selected:
            UIView.animate(withDuration: 0.2) { [self] in
                backgroundColor = Colors.lightBlue
                layer.borderColor = UIColor.clear.cgColor
            }
        case .notSelected:
            UIView.animate(withDuration: 0.2) { [self] in
                layer.borderColor = Colors.dirtyBlue.cgColor
                backgroundColor = .clear
                layer.borderWidth = 1
            }
        }
        layoutIfNeeded()
    }
}
