//
//  DSEventParticipateButton.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import UIKit

final class DSEventParticipateButton: UIButton {
    
    enum State {
        case selected, notSeleted
    }
    
    private var buttonState: State = .notSeleted {
        didSet {
            handleStateChange()
        }
    }
    
    //MARK: - Init
    
    init(title: String = "", state: State) {
        super.init(frame: .zero)
        
        layer.cornerRadius = 8
        setTitle(Texts.Event.participate, for: .normal)
        backgroundColor = Colors.lightBlue
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = Fonts.sfProRegular(size: 18)
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Public methods

extension DSEventParticipateButton {
    
    func bind() {
        switch buttonState {
        case .notSeleted:
            buttonState = .selected
        case .selected:
            buttonState = .notSeleted
        }
    }
}

//MARK: - Private methods

private extension DSEventParticipateButton {
    
    func handleStateChange() {
        switch buttonState {
        case .notSeleted:
            UIView.animate(withDuration: 0.25) { [self] in
                setTitle(Texts.Event.participate, for: .normal)
                backgroundColor = Colors.lightBlue
            }
        case .selected:
            UIView.animate(withDuration: 0.25) { [self] in
                setTitle(Texts.Event.participating, for: .normal)
                backgroundColor = Colors.lightBlue_02
            }
        }
    }
}
