//
//  File.swift
//  DoSport
//
//  Created by Sergey on 22.01.2021.
//

import UIKit

class PreviewLocation: UIViewController   {
    let id: Int
    let name: String
    let range: Int
    let price: Int
    let location: String
    init(id: Int, name: String, range: Int, price: Int, location: String) {
        self.id = id
        self.name = name
        self.range = range
        self.price = price
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - UI
    private lazy var background : UIView = {
        let view = UIView()
        view.backgroundColor = Colors.lightBlue
        return view
    }()
    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.text = location
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = String(price)
        return label
    }()
    private lazy var rangeLabel: UILabel = {
        let label = UILabel()
        label.text = String(range)
        return label
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = name
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
    
    func setupUI() {
        view.backgroundColor = Colors.darkBlue
        view.addSubviews(background,adressLabel,priceLabel,rangeLabel,nameLabel, metroIcon,locationIcon,priceIcon)
        background.snp.makeConstraints { (make) in
            make.left.top.equalTo(view).offset(view.bounds.width / 23.4)
            make.right.bottom.equalTo(view).offset(-view.bounds.width / 23.4)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(background.snp.left).offset(background.bounds.width / 28.5)
            make.top.equalTo(background.snp.centerY)
            make.height.equalTo(background.bounds.height / 10)
        }
        metroIcon.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        adressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(metroIcon.snp.right).offset(4)
            make.top.equalTo(metroIcon.snp.top)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(adressLabel.snp.bottom)
            make.right.equalTo(background.snp.right).offset(background.bounds.width / 28.5)
        }
        priceIcon.snp.makeConstraints { (make) in
            make.right.equalTo(priceLabel.snp.left).offset(-6) //changed
            make.bottom.equalTo(priceLabel.snp.bottom)
        }
        rangeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(background.snp.right).offset(background.bounds.width / 28.5)
            make.bottom.equalTo(priceLabel.snp.top)
        }
        locationIcon.snp.makeConstraints { (make) in
            make.right.equalTo(rangeLabel.snp.left).offset(5)
            make.centerX.equalTo(rangeLabel.snp.centerX)
        }
    }
}
