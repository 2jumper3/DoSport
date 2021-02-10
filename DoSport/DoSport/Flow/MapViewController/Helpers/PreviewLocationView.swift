//
//  PreviewLocationView.swift
//  DoSport
//
//  Created by Sergey on 07.02.2021.
//


import UIKit

class PreviewLocationView: UIView   {
//    let id: Int?
//    let name: String?
//    let range: Int?
//    let price: Int?
//    let location: String?
//    init(frame: CGRect, id: Int, name: String, range: Int, price: Int, location: String) {
    override init (frame: CGRect) {
//        self.id = id
//        self.name = name
//        self.range = range
//        self.price = price
//        self.location = location
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        setupUI()
    }
    
    //MARK: - UI
    private lazy var background : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = Colors.lightBlue
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
        layoutSubviews()
    }
    
    func setupUI() {
        backgroundColor = Colors.darkBlue
        addSubviews(background,
                    customBlueBorder,adressLabel,priceLabel,rangeLabel,nameLabel, metroIcon,locationIcon,priceIcon)
        background.snp.makeConstraints { (make) in
            make.left.top.right.left.equalTo(self)
        }
//        background.snp.makeConstraints { (make) in
//            make.left.right.equalTo(customBlueBorder)
//            make.top.equalTo(customBlueBorder.snp.top).offset(5)
//            make.bottom.equalTo(customBlueBorder.snp.bottom).offset(-5)
//        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left).offset(10)
            make.centerY.equalTo(snp.centerY)
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
            make.right.equalTo(snp.right).offset(-10)
            make.height.equalTo(22)
        }
        priceIcon.snp.makeConstraints { (make) in
            make.right.equalTo(priceLabel.snp.left).offset(-6)
            make.centerY.equalTo(priceLabel.snp.centerY)
        }
        rangeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(snp.right).offset(-10)
            make.bottom.equalTo(priceLabel.snp.top)
            make.height.equalTo(22)
        }
        locationIcon.snp.makeConstraints { (make) in
            make.right.equalTo(rangeLabel.snp.left).offset(-6)
            make.centerY.equalTo(rangeLabel.snp.centerY)
        }
    }
}
