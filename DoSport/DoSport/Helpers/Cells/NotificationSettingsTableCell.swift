//
//  NotificationSettingsTableCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

final class NotificationSettingsTableCell: UITableViewCell {
    
    //MARK: Outlets
    
    private lazy var switchControl = DSSwitch()

    //MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        guard let textLabel = self.textLabel else { return }
        textLabel.textColor = .white
        textLabel.font = Fonts.sfProRegular(size: 18)
        
        backgroundColor = Colors.darkBlue
        selectionStyle = .none
        contentView.addSubviews(switchControl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switchControl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-5)
        }
    }
}

