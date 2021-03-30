//
//  CollectionViewSportTypeCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class CollectionViewSportTypeCell: UICollectionViewCell {
    
    var text: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    //MARK: Outlets
    
    private let titleLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 16)
        $0.textAlignment = .center
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = Colors.dirtyBlue.cgColor
        backgroundColor = .clear
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//MARK: Public API

extension CollectionViewSportTypeCell {
    
    func bind(isSelected: Bool) {
        if isSelected {
            backgroundColor = Colors.lightBlue
        } else {
            backgroundColor = .clear
        }
    }
}
