//
//  CommonButton.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

final class CommonButton: UIButton {
    
    enum State {
        case disabled, normal
    }
    
    private var commonState: State = .normal {
        didSet {
            setState()
        }
    }
    
    //MARK: - Init
    
    init(title: String = "", state: State = .normal) {
        super.init(frame: .zero)
        layer.cornerRadius = 8
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

extension CommonButton {
    
    func bind(state: State) {
        commonState = state
    }
}

//MARK: - Private methods

private extension CommonButton {
    
    func setState() {
        switch commonState {
        case .disabled:
            isUserInteractionEnabled = false
            backgroundColor = Colors.dirtyBlue
        case .normal:
            isUserInteractionEnabled = true
            backgroundColor = Colors.lightBlue
        }
    }
}
