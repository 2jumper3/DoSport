//
//  CommonButton.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

protocol CommonButtonDelegate: AnyObject {
    func commonButtonTapped(_ commonButton: CommonButton, tappedWithState: CommonButton.State)
}

final class CommonButton: UIButton {
    
    weak var delegate: CommonButtonDelegate?
    
    enum State {
        case disabled
        case normal
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
        bind(title: title, state: state)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Bind
    
    func bind(title: String = "", state: State) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        commonState = state
    }
    
    override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        super.addTarget(target, action: action, for: controlEvents)
        
        if controlEvents == .touchUpInside {
            currentButtonPressed()
        }
    }
    
    private func setState() {
        switch commonState {
        case .disabled:
            isUserInteractionEnabled = false
            backgroundColor = Colors.dirtyBlue
        case .normal:
            isUserInteractionEnabled = true
            backgroundColor = Colors.lightBlue
        }
    }
    
    // MARK: - Actions
    
    @objc private func currentButtonPressed() {
        delegate?.commonButtonTapped(self, tappedWithState: commonState)
    }
}
