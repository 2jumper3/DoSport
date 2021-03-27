//
//  DSEmptyView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/01/2021.
//

import UIKit.UIView

/// This class describes an emptyView object that is used to show some provide text to the user when screen's content can not be loaded.
final class DSEmptyView: UIView {
    
    private lazy var label: UILabel = {
        $0.textAlignment = .center
        $0.textColor = Colors.mainBlue
        $0.text = Texts.CountryList.noResults
        $0.font = Fonts.sfProRegular(size: 15)
        $0.numberOfLines = 2
        return $0
    }(UILabel())

    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(snp.width).multipliedBy(0.5)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
    }
}

