//
//  SelectionCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

final class SelectionCell: UITableViewCell {
    
    var onTitleDidSet: ((String) -> Void)?
    
    // MARK: Outlets
    
    private lazy var myTitleLabel: UILabel = {
        $0.textColor = Colors.dirtyBlue
        $0.font = Fonts.sfProRegular(size: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var myImageView: UIImageView = {
        $0.image = Icons.EventCreate.next
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    //MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(myTitleLabel, myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.height.equalToSuperview().multipliedBy(0.366)
        }
        
        myImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(12)
            $0.height.equalTo(myTitleLabel.snp.height).multipliedBy(0.7)
            $0.width.equalTo(myImageView.snp.height).multipliedBy(0.7)
        }
    }
}

//MARK: Public API

extension SelectionCell {
    
    func bind(_ text: String) {
        myTitleLabel.text = text
        
        if text != Texts.EventCreate.date &&
            text != Texts.EventCreate.sportTypes &&
            text != Texts.EventCreate.playground {
            
            myTitleLabel.textColor = .white
            onTitleDidSet?(text)
        }
    }
}

