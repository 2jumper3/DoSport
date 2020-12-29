//
//  CountryListTableCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 29/12/2020.
//

import UIKit

final class CountryListTableCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        $0.textAlignment = .left
        $0.textColor = .white
        $0.font = Fonts.sfProRegular(size: 16)
        return $0
    }(UILabel())
    
    private let callingCodeLabel: UILabel = {
        $0.textAlignment = .right
        $0.textColor = .white
        $0.font = Fonts.sfProRegular(size: 16)
        return $0
    }(UILabel())
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Colors.darkBlue
        selectionStyle = .none
        addSubviews(nameLabel, callingCodeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
        }
        
        callingCodeLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-10)
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.2)
        }
    }
}

//MARK: - Public Methods

extension CountryListTableCell {
    func bind(country: Country) {
        self.nameLabel.text = country.name
        self.callingCodeLabel.text = country.callingCode
    }
}
