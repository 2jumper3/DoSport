//
//  PreviewLocationView.swift
//  DoSport
//
//  Created by Sergey on 07.02.2021.
//


import UIKit

class PreviewLocationView: UIView   {

    override init (frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        setupUI()
//        addTapGesture()
    }
    
    //MARK: - UI
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapOnView(tapGestureRecognizer:)))
        return gesture
    }()

    private lazy var background : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = Colors.lightBlue
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        return view
    }()
    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProRegular(size: 14)
        label.textColor = .white
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProRegular(size: 14)
        label.textColor = .white
        return label
    }()
    private lazy var rangeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProRegular(size: 14)
        label.textColor = .white
        return label
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProRegular(size: 24)
        label.textColor = .white
        label.isUserInteractionEnabled = true
        return label
    }()
    private lazy var metroIcon: UIImageView = {
        let imageView = UIImageView(image: Icons.PlacemarkTapped.metro)
        return imageView
    }()
    private lazy var locationIcon: UIImageView = {
        let imageView = UIImageView(image: Icons.PlacemarkTapped.location)
        return imageView
    }()
    private lazy var priceIcon: UIImageView = {
        let imageView = UIImageView(image: Icons.PlacemarkTapped.price)
        return imageView
    }()
    private lazy var customBlueBorder: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.dirtyBlue
        return view
    }()

    func textAdding(id: Int, name: String, range: Int, price: Int, location: String ) {
        priceLabel.text = String(price)
        adressLabel.text = location
        rangeLabel.text = String("\(range) км")
        nameLabel.text = name
    }
    //MARK: - Actions TODO
    @objc func tapOnView(tapGestureRecognizer: UITapGestureRecognizer) {
        guard tapGestureRecognizer.view != nil else { return }
        if tapGestureRecognizer.state == .ended {
            // place route to next screen 
        }
    }
    
    //MARK: - SetupUI
    func setupUI() {
        backgroundColor = Colors.darkBlue
        addSubviews(background,
                    adressLabel,priceLabel,rangeLabel,nameLabel, metroIcon,locationIcon,priceIcon)
        background.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(self.bounds.width / 23.4)
            make.right.equalTo(self.snp.right).offset(-self.bounds.width / 23.4)
            make.top.equalTo(self.snp.top).offset(self.bounds.width / 23.4)
            make.bottom.equalTo(self.snp.bottom).offset(-self.bounds.width / 23.4)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(background.snp.left).offset(10)
            make.centerY.equalTo(background.snp.centerY)
        }
        metroIcon.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        adressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(metroIcon.snp.right).offset(4)
            make.centerY.equalTo(metroIcon.snp.centerY)
            make.height.equalTo(22)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(adressLabel.snp.centerY)
            make.right.equalTo(background.snp.right).offset(-10)
            make.height.equalTo(22)
        }
        priceIcon.snp.makeConstraints { (make) in
            make.right.equalTo(priceLabel.snp.left).offset(-6)
            make.centerY.equalTo(priceLabel.snp.centerY)
        }
        rangeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(background.snp.right).offset(-10)
            make.bottom.equalTo(priceLabel.snp.top)
            make.height.equalTo(22)
        }
        locationIcon.snp.makeConstraints { (make) in
            make.right.equalTo(rangeLabel.snp.left).offset(-6)
            make.centerY.equalTo(rangeLabel.snp.centerY)
        }
    }
}
