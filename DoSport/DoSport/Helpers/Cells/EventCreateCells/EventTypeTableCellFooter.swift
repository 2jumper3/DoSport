//
//  EventTypeTableCellFooter.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import UIKit

final class EventTypeTableCellFooter: UITableViewHeaderFooterView {

    //MARK: Outlets
    
    private let footerLabel: UILabel = {
        $0.text = Texts.EventCreate.closedEventInfo
        $0.textColor = Colors.dirtyBlue
        $0.textAlignment = .left
        $0.numberOfLines = 3
        $0.font = Fonts.sfProRegular(size: 14)
        return $0
    }(UILabel())
    
    //MARK: Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(footerLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        footerLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
    }
}
