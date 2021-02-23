//
//  CountryListTableCellHeaderView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/01/2021.
//

import UIKit
import SnapKit

final class CountryListTableCellHeaderView: UIView {
    
    private lazy var titleLabel: UILabel = {
        $0.textColor = Colors.mainBlue
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        backgroundColor = Colors.darkBlue
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints {
            $0.centerY.centerX.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
    }
}
