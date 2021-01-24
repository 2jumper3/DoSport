//
//  MenuCell.swift
//  DoSport
//
//  Created by MAC on 20.01.2021.
//

import UIKit

class MenuBarViewCell: UICollectionViewCell {

    // MARK: - Outlets
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Colors.mainBlue
        label.font = Fonts.sfProRegular(size: 18)
        return label
    }()

    // MARK: - Properties
    static let reuseId = "MenuBarCell"
    override var isHighlighted: Bool {
        didSet {
            titleLabel.textColor = isHighlighted ? UIColor.white : Colors.mainBlue
        }
    }
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? UIColor.white : Colors.mainBlue
        }
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame:frame)
        configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure UI
    private func configureUI() {
        backgroundColor = Colors.darkBlue
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    func configureCell(title: String) {
        titleLabel.text = title
    }
}
