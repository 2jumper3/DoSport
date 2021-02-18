//
//  CollectionViewHoursCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 13/02/2021.
//

import UIKit

/// `available`, `notAvalable` states are used to handle whether or not the hour is available for selected sport ground.
/// And `Bool` associated type is used to handle cell's selected or not selected state by switching true & false.
enum HoursCellState: Equatable {
    case available(Bool), notAvailable
}

final class CollectionViewHoursCell: UICollectionViewCell {
    
    var cellState: HoursCellState = .notAvailable {
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

    //MARK: Init
    
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

//MARK: Public API

extension CollectionViewHoursCell {
    
    func bind(state: HoursCellState) {
        cellState = state
    }
}

//MARK: Private API

private extension CollectionViewHoursCell {
    
    func handleStateChange() {
        switch cellState {
        case .available(let isSelected):
            myTitleLabel.textColor = .white
            
            if isSelected {
                UIView.animate(withDuration: 0.2) { [self] in
                    layer.borderColor = Colors.darkBlue.cgColor
                    backgroundColor = Colors.lightBlue
                }
            } else {
                UIView.animate(withDuration: 0.2) { [self] in
                    layer.borderColor = Colors.dirtyBlue.cgColor
                    backgroundColor = Colors.darkBlue
                }
            }
            
        case .notAvailable:
            UIView.animate(withDuration: 0.2) { [self] in
                myTitleLabel.textColor = Colors.dirtyBlue
                layer.borderColor = Colors.dirtyBlue.cgColor
                backgroundColor = Colors.darkBlue
            }
        }
    }
}
