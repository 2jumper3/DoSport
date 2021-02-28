//
//  RegularTableCellWithPointer.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

final class RegularTableCellWithPointer: UITableViewCell {
    
    //MARK: Outlets
    
    private let pointerImageView: UIImageView = {
        $0.image = Icons.Settings.next
        $0.setImageColor(color: Colors.dirtyBlue)
        return $0
    }(UIImageView())

    //MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel?.textColor = .white
        textLabel?.font = Fonts.sfProRegular(size: 18)
        
        backgroundColor = Colors.darkBlue
        selectionStyle = .none
        contentView.addSubviews(pointerImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pointerImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.35)
            $0.width.equalTo(pointerImageView.snp.height).multipliedBy(0.55)
        }
    }
}
