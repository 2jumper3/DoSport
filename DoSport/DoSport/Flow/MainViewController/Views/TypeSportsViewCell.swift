//
//  MainViewCell.swift
//  DoSport
//
//  Created by MAC on 14.01.2021.
//

import UIKit

final class TypeSportsViewCell: UICollectionViewCell {

    // MARK: - Outlets
    private var nameTypeSport: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProRegular(size: 16)
        label.textColor = .white
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()

    // MARK: - Propeties
    static let reuseId = "MainViewCell"

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }

    // MARK: - Helpers functions
    private func setupUI() {
        self.backgroundColor = Colors.lightBlue
        self.layer.cornerRadius = 12

        addSubview(nameTypeSport)
        nameTypeSport.snp.makeConstraints { (make) in
            make.top.leading.equalTo(self).offset(12)
            make.trailing.equalTo(self).offset(-12)
        }

        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.bottom.trailing.equalTo(self).offset(-12)
            make.width.height.equalTo(40)
        }
    }

    func configureCell(typeOfSport: SportTypeModel) {
        self.nameTypeSport.text = typeOfSport.titleType.description
        self.imageView.image = UIImage(named: typeOfSport.iconType)
    }
}
