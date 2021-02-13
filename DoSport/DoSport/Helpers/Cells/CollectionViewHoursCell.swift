//
//  CollectionViewHoursCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 13/02/2021.
//

import UIKit

final class CollectionViewHoursCell: UICollectionViewCell {
    
    enum CellState {
        case selected, notSelected
    }

    var cellState: CellState = .notSelected {
        didSet {
            handleStateChange()
        }
    }
    
    private(set) var myTitleLabel: UILabel = {
        $0.font = Fonts.sfProRegular(size: 16.5)
        $0.textAlignment = .center
        $0.textColor = Colors.dirtyBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = Colors.dirtyBlue.cgColor
        contentView.addSubview(myTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myTitleLabel.snp.makeConstraints {
            $0.centerX.centerY.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.94)
            
        }
    }
}

//MARK: - Public methods

extension CollectionViewHoursCell {
    
    func bind(state: CellState) {
        cellState = state
    }
}

//MARK: - Private methods

private extension CollectionViewHoursCell {
    
    func handleStateChange() {
        switch cellState {
        case .notSelected:
            UIView.animate(withDuration: 0.3) { [self] in
                myTitleLabel.textColor = Colors.dirtyBlue
                layer.borderColor = Colors.dirtyBlue.cgColor
            }
        case .selected:
            UIView.animate(withDuration: 0.3) { [self] in
                myTitleLabel.textColor = .white
                layer.borderColor = UIColor.white.cgColor
            }
        }
    }
}

//enum CellState {
//    case available(Bool), notAvailable
//}
//
//func handleStateChange() {
//    switch cellState {
//    case .available(let isSelected):
//        if isSelected {
//            backgroundColor = Colors.lightBlue
//            myTitleLabel.textColor = .white
//            layer.borderColor = Colors.lightBlue.cgColor
//        } else {
//            myTitleLabel.textColor = .white
//            layer.borderColor = Colors.darkBlue.cgColor
//        }
//    case .notAvailable:
//        myTitleLabel.textColor = Colors.dirtyBlue
//        layer.borderColor = Colors.dirtyBlue.cgColor
//    }
//}
