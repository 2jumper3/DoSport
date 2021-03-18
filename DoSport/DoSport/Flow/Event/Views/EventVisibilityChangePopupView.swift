//
//  EventVisibilityChangePopupView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 16/03/2021.
//

import UIKit

final class EventVisibilityChangePopupView: UIView {
    
    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = Fonts.sfProRegular(size: 18)
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private let bodyLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = Fonts.sfProRegular(size: 16)
        $0.textColor = .white
        $0.numberOfLines = 3
        return $0
    }(UILabel())
    
    init(isClosedType: Bool) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0.0
        self.isUserInteractionEnabled = false
        self.backgroundColor = Colors.mainBlue
        self.layer.cornerRadius = 12
        if isClosedType {
            self.bodyLabel.text = "Теперь в ней смогут участвовать только те игроки, кто получил приглашение от тебя."
            self.titleLabel.text = "Закрытая тренировка"
        } else {
            self.bodyLabel.text = ""
            self.titleLabel.text = ""
        }
        
        addSubviews(titleLabel, bodyLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.bottom.equalTo(bodyLabel.snp.top).offset(-10)
        }
        
        bodyLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.45)
            $0.bottom.equalToSuperview().offset(-16)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
    }
}

