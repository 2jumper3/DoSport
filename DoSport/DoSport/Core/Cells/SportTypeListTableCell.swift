//
//  SportTypeListTableCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 13/02/2021.
//

import UIKit

final class SportTypeListTableCell: UITableViewCell {
    
    enum CellState {
        case selected, notSelected
    }
        
    var cellState: CellState = .notSelected {
        didSet {
            handleCellStateChange()
        }
    }
    
    //MARK: Outlets
    
    private let checkmarkImageView: UIImageView = {
        $0.image = Icons.SportTypeList.checkMark
        $0.isHidden = true
        return $0
    }(UIImageView())

    //MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        backgroundColor = Colors.darkBlue
        selectionStyle = .none
        
        guard let label = textLabel else { return }
        label.textColor = Colors.mainBlue
        label.font = Fonts.sfProRegular(size: 18)
        
        contentView.addSubviews(checkmarkImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bind(state: .notSelected)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        checkmarkImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.width.equalTo(checkmarkImageView.snp.height).multipliedBy(1.2)
        }
    }
}

//MARK: Public API

extension SportTypeListTableCell {

    func bind(state: CellState) {
        cellState = state
    }
    
    func bind(isChoosen: Bool) {
        handleCellStateChange(isChoosen)
    }
}

//MARK: Private API

private extension SportTypeListTableCell {
    
    func handleCellStateChange(_ isChoosen: Bool) {
        guard let label = textLabel else { return }
        
        if isChoosen {
            UIView.animate(withDuration: 0.15) { [self] in
                label.textColor = .white
                checkmarkImageView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.15) { [self] in
                label.textColor = Colors.mainBlue
                checkmarkImageView.isHidden = true
            }
        }
    }
 
    func handleCellStateChange() {
        guard let label = textLabel else { return }
        
        switch cellState {
        case .selected:
            UIView.animate(withDuration: 0.15) { [self] in
                label.textColor = .white
                checkmarkImageView.isHidden = false
            }
        case .notSelected:
            UIView.animate(withDuration: 0.15) { [self] in
                label.textColor = Colors.mainBlue
                checkmarkImageView.isHidden = true
            }
        }
    }
}
