//
//  PhoneNumberAddView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit
import SnapKit

final class PhoneNumberAddView: UIView {
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = Fonts.sfProRegular(size: 12)
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    //MARK: - Life Cycle
    
    init() {
        super.init(frame: .zero)
        addSubviews(button, textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        button.snp.makeConstraints {
            $0.left.centerY.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.2)
        }
        
        textField.snp.makeConstraints {
            $0.left.centerY.height.equalTo(button)
            $0.right.equalToSuperview()
        }
    }
}
