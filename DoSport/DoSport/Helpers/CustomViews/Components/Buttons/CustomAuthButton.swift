//
//  CustomAuthButton.swift
//  DoSport
//
//  Created by Sergey on 11.03.2021.
//


import UIKit

enum CustomAuthButtonState {
    case disabled, normal
}

final class CustomAuthButton: UIButton {
    
    private var buttonState: CustomAuthButtonState = .normal {
        didSet {
            handleStateChange()
        }
    }
    
    //MARK: Init
    
    init(
        title: String = "",
        state: CustomAuthButtonState = .normal,
        image: UIImage,
        isHidden: Bool = false
    ) {
        super.init(frame: .zero)
        
        layer.cornerRadius = 8
        self.isHidden = isHidden
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray, for: .highlighted)
        translatesAutoresizingMaskIntoConstraints = false
        setAuthImage(image: image)
        bind(state: state)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Public API

extension CustomAuthButton {
    
    func bind(state: CustomAuthButtonState) {
        buttonState = state
    }
    
    func isHidden(_ value: Bool) {
        self.isHidden = value
    }
    
    func getState() -> CustomAuthButtonState {
        return buttonState
    }
    func setAuthImage(image: UIImage) {
        let imageAuthView = UIImageView(image: image)
        self.addSubview(imageAuthView)
        imageAuthView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalTo(self.snp.left).offset(25)
        }
    }
}

//MARK: Private API

private extension CustomAuthButton {
    
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
