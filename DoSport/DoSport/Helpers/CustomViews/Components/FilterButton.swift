//
//  FilterButton.swift
//  DoSport
//
//  Created by Sergey on 30.12.2020.
//

import UIKit

class FilterButton: UIButton {
    enum State {
        case activated
        case notActivated
    }
    private var buttonState: State = .activated {
        didSet {
            setState()
        }
    }
    //MARK: - Init
    init(state: State = .activated) {
        super.init(frame: .zero)
        layer.cornerRadius = 8
        layer.borderColor = Colors.lightBlue.cgColor
        layer.borderWidth = 1
        bind(state: state)
        setupImage()
    }
    //MARK: - Bind
    
    func bind(state: State) {
        setTitleColor(.white, for: .normal)
        buttonState = state
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Image
    private var buttonImage = UIImageView(image: Icons.FilterIcon.filter)

    func setupImage() {
        addSubview(buttonImage)
        buttonImage.translatesAutoresizingMaskIntoConstraints = false
        buttonImage.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(14)
            make.left.equalTo(self.snp.left).offset(12)
            make.width.equalTo(16)
            make.height.equalTo(12)
        }
    }

    //MARK: - ButtonSetup
    private func setState() {
        switch buttonState {
        case .notActivated:
            backgroundColor = Colors.darkBlue
            buttonImage = UIImageView(image: Icons.FilterIcon.filter)
        case .activated:
            backgroundColor = Colors.lightBlue
            buttonImage =  UIImageView(image: Icons.FilterIcon.filter)
        }
    }

}
