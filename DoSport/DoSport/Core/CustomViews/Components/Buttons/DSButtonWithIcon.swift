//
//  DSButtonWithIcon.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import UIKit

final class DSButtonWithIcon: UIView {
    
    private lazy var label: UILabel = {
        $0.textColor = .white
        $0.textAlignment = .left
        return $0
    }(UILabel())

    private lazy var imageView: UIImageView = UIImageView()
    
    private let isTextInCenter: Bool
    private let isBindable: Bool
    
    //MARK: Init
    
    init(img icon: UIImage,
         txt text: String,
         textColor: UIColor = .white,
         imageColor: UIColor = .white,
         isTextInCenter: Bool = false,
         isBindable: Bool = true
    ) {
        self.isTextInCenter = isTextInCenter
        self.isBindable = isBindable
        super.init(frame: .zero)
        
        layer.cornerRadius = 8
        label.text = text
        label.textColor = textColor
        imageView.image = icon.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = imageColor
        
        addSubviews(label, imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = Colors.lightBlue
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalTo(self.snp.left).offset(25)
        }
        
        if self.isTextInCenter {
            label.snp.makeConstraints {
                $0.centerY.height.equalToSuperview()
                $0.center.equalToSuperview()
            }
        } else {
            label.snp.makeConstraints {
                $0.centerY.height.equalToSuperview()
                $0.left.equalTo(imageView.snp.right).offset(16)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if isBindable {
            bind(didTapped: true)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        if isBindable {
            bind(didTapped: false)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if isBindable {
            bind(didTapped: false)
        }
    }
}

//MARK: Public API

extension DSButtonWithIcon {
    
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
    
    func addTarget(_ target: Any?, action: Selector?) {
        let gesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(gesture)
    }
}

