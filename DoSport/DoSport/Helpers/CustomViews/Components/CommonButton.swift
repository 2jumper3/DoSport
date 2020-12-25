//
//  CommonButton.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//
import UIKit

/**
 Usage:
 You have to confirm `CommonButtonDelegate` from your ViewController where you want to handle this button click
 
 Sample:
 ```
 extension SomViewController: CommonButtonDelegate {
 
        func commonButtonTapped(_ sender: CommonButton, tappedWithState: CommonButton.State) {
            ```you click handle code goes here ```
        }
 
    }
 */

protocol CommonButtonDelegate: AnyObject {
    func commonButtonTapped(_ sender: CommonButton, tappedWithState: CommonButton.State)
}

final class CommonButton: UIButton {
    
    weak var delegate: CommonButtonDelegate?
    
    enum State {
        case disabled(title: String? = "")
        case normal(title: String? = "")
    }
    
    private var commonState: State = .normal() {
        didSet {
            setState()
        }
    }
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        layer.cornerRadius = 8
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Bind
    
    func bind(state: State) {
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
        case .disabled(let title):
            setTitle(title, for: .disabled)
            setTitleColor(.white, for: .disabled)
            backgroundColor = Colors.dirtyBlue
        case .normal(let title):
            setTitle(title, for: .normal)
            setTitleColor(.white, for: .normal)
            backgroundColor = Colors.lightBlue
        }
    }
    
    // MARK: - Actions
    
    @objc private func currentButtonPressed() {
        delegate?.commonButtonTapped(self, tappedWithState: commonState)
    }
}
