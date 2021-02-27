//
//  DSEventControlButton.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import UIKit

final class DSEventControlButton: UIView {
    
    private lazy var label: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .left
        return $0
    }(UILabel())

    private lazy var imageView: UIImageView = {
        $0.image = UIImage()
    return $0
    }(UIImageView())
    
    //MARK: Init
    
    init(img icon: UIImage, txt text: String) {
        super.init(frame: .zero)
        
        label.text = text
        imageView.image = icon
        
        addSubviews(label, imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.left.equalToSuperview()
            $0.width.equalTo(imageView.snp.height)
        }
        
        label.snp.makeConstraints {
            $0.centerY.height.equalToSuperview()
            $0.left.equalTo(imageView.snp.right).offset(16)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        bind(didTapped: true)
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        bind(didTapped: false)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        bind(didTapped: false)
    }
}

//MARK: Public API

extension DSEventControlButton {
    
    func bind(didTapped: Bool) {
        if didTapped {
            UIViewPropertyAnimator(duration: 0.2, curve: .linear) { [unowned self] in
                imageView.setImageColor(color: .lightGray)
                label.textColor = .darkGray
            }.startAnimation()
        } else {
            UIViewPropertyAnimator(duration: 0.2, curve: .linear) { [unowned self] in
                imageView.setImageColor(color: .white)
                label.textColor = .white
            }.startAnimation()
        }
    }
}

