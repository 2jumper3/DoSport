//
//  OnBoardingCell.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import UIKit

final class OnBoardingViewCell: UICollectionViewCell {

    // MARK: - Outlets
    static let reuseId = "PageViewCell"

    var page: OnBoardingModel? {
        didSet {
            guard let page = page else { return }
            imageView.image = page.image
            headerLabel.text = page.textHeader
            descriptionLabel.text = page.textDescription
        }
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icons.OnboardingIcons.firstIcon
        imageView.image?.withRenderingMode(.alwaysOriginal)
        imageView.backgroundColor = .clear
        return imageView
    }()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProRegular(size: 32)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.font = Fonts.sfProRegular(size: 16)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.adjustsFontForContentSizeCategory = true
        textView.textAlignment = .center
        textView.isUserInteractionEnabled = false
        return textView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.lightBlue
        layoutSubview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers functions
    func layoutSubview() {
        contentView.addSubview(imageView)
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(120)
            make.width.equalTo(220)
            make.height.equalTo(180)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        let textStackView = UIStackView(arrangedSubviews: [
            headerLabel,descriptionLabel
        ])
        textStackView.spacing = 0
        textStackView.axis = .vertical
        addSubview(textStackView)
        textStackView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(52.35)
            make.width.equalTo(327)
            make.height.equalTo(200)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
}
