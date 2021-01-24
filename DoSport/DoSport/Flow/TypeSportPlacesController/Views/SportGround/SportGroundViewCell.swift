//
//  SportGroundViewCell.swift
//  DoSport
//
//  Created by MAC on 23.01.2021.
//

import UIKit

final class SportGroundViewCell: UICollectionViewCell {

    // MARK: - Outlets
    private let backGroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "sportground")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundBlue
        view.layer.cornerRadius = 12
        return view
    }()
    private let sportGroundNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProRegular(size: 24)
        label.textColor = .white
        return label
    }()
    private let metroNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProRegular(size: 14)
        label.textColor = .white
        return label
    }()
    private let directionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Fonts.sfProRegular(size: 14)
        return label
    }()
    private let iconMetroImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private let iconDirectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "icondirection").withRenderingMode(.alwaysOriginal)
        return imageView
    }()
    private let iconPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "\u{20BD}"
        label.textColor = .white
        label.font = Fonts.sfProRegular(size: 18)
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Fonts.sfProRegular(size: 14)
        return label
    }()

    // MARK: - Properties
    static let reuseId = "SportGroundViewCell"

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
        layer.cornerRadius = 12
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure UI
    private func configureUI() {
        setupBackgroundViews()
        setupBottomViews()
        setupTopViews()
    }

    private func setupBackgroundViews() {
        addSubview(backGroundImageView)
        addSubview(backGroundView)
        backGroundView.alpha = 0.8
        backGroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        backGroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    private func setupTopViews() {
        addSubview(sportGroundNameLabel)
        addSubview(iconDirectionImageView)
        addSubview(directionLabel)

        sportGroundNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(12)
            make.bottom.equalTo(iconMetroImageView.snp.top).offset(-5)
        }
        directionLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(-12)
            make.centerY.equalTo(sportGroundNameLabel.snp.centerY).offset(3)
        }
        iconDirectionImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(directionLabel.snp.leading).offset(-5)
            make.centerY.equalTo(directionLabel.snp.centerY)
            make.width.height.equalTo(13)
        }
    }

    private func setupBottomViews() {
        addSubview(iconMetroImageView)
        addSubview(metroNameLabel)
        addSubview(priceLabel)
        addSubview(iconPriceLabel)
        iconMetroImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(12)
            make.bottom.equalTo(-19)
            make.width.equalTo(16)
            make.height.equalTo(12)
        }
        metroNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(iconMetroImageView.snp.trailing).offset(5)
            make.centerY.equalTo(iconMetroImageView.snp.centerY)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(-12)
            make.centerY.equalTo(iconMetroImageView.snp.centerY)
        }
        iconPriceLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(priceLabel.snp.leading).offset(-6)
            make.centerY.equalTo(iconMetroImageView.snp.centerY)
        }
    }

    // MARK: - Configure cells
    func setupCell(sportGroundModel: SportGroundModel) {
        sportGroundNameLabel.text = sportGroundModel.sportGroundName
        directionLabel.text = "\(sportGroundModel.directionToPlace) км"
        metroNameLabel.text = sportGroundModel.metroName
        iconMetroImageView.image = sportGroundModel.metroLine.icon
        priceLabel.text = sportGroundModel.price
    }
}
