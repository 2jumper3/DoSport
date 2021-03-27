//
//  MainSportTypeSelectionTableCell.swift
//  DoSport
//
//  Created by MAC on 03.03.2021.
//

import UIKit

final class MainSportTypeSelectionTableCell: UICollectionViewCell {
    
    struct ViewData {
        let name: String?
        let image: UIImage?
    }

    // MARK: Outlets
    
    private lazy var sportTypeNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProRegular(size: 16)
        label.textColor = .white
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var sportTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()

    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = Colors.lightBlue
        layer.cornerRadius = 12
        
        addSubviews(sportTypeNameLabel, sportTypeImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.sportTypeImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sportTypeNameLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(self).offset(12)
            make.trailing.equalTo(self).offset(-12)
        }
        
        sportTypeImageView.snp.makeConstraints { (make) in
            make.bottom.trailing.equalTo(self).offset(-12)
            make.width.height.equalTo(40)
        }
    }
}

//MARK: Public API

extension MainSportTypeSelectionTableCell {
    
    func bind(data: MainSportTypeSelectionTableCell.ViewData) {
        sportTypeNameLabel.text = data.name
        sportTypeImageView.image = data.image
    }
}
