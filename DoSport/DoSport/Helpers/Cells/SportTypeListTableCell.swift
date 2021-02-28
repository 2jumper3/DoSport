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
    
    var titleText: String? {
        get { myTitleLabel.text }
        set { myTitleLabel.text = newValue }
    }
    
    //MARK: Outlets
    
    private let myTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = Colors.mainBlue
        $0.font = Fonts.sfProRegular(size: 18)
        return $0
    }(UILabel())
    
    private let checkmarkImageView: UIImageView = {
        $0.image = Icons.SportTypeList.checkMark
        $0.setImageColor(color: .clear)
        return $0
    }(UIImageView())

    //MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        backgroundColor = Colors.darkBlue
        selectionStyle = .none
        
        contentView.addSubviews(
            myTitleLabel,
            checkmarkImageView
        )
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
        
        myTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
            $0.height.equalToSuperview().multipliedBy(0.75)
        }
        
        checkmarkImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.width.equalTo(checkmarkImageView.snp.height).multipliedBy(1.2)
        }
    }
}

//MARK: Public c

extension SportTypeListTableCell {

    func bind(state: CellState) {
        cellState = state
    }
}

//MARK: Private TableView

private extension SportTypeListTableCell {
 
    func handleCellStateChange() {
        switch cellState {
        case .selected:
            UIView.animate(withDuration: 0.15) { [self] in
                myTitleLabel.textColor = .white
                checkmarkImageView.setImageColor(color: .white)
            }
        case .notSelected:
            UIView.animate(withDuration: 0.15) { [self] in
                myTitleLabel.textColor = Colors.mainBlue
                checkmarkImageView.setImageColor(color: .clear)
            }
        }
    }
}
