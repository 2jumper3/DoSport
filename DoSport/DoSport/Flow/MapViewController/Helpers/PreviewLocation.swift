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
    private let tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnView(tapGestureRecognizer:)))
        return tap
    }()
    private lazy var background : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = Colors.lightBlue
        return view
    }()
    private lazy var viewForTapRecognizer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProRegular(size: 14)
        label.textColor = .white
        label.text = location
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProRegular(size: 14)
        label.textColor = .white
        label.text = String(price)
        return label
    }()
    private lazy var rangeLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProRegular(size: 14)
        label.textColor = .white
        label.text = String("\(range) км")
        return label
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = name
        label.font = Fonts.sfProRegular(size: 24)
        label.textColor = .white
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
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
        view.backgroundColor = Colors.lightBlue
        return view
    }()
    
    //MARK: - Actions
    @objc func tapOnView(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedView = tapGestureRecognizer.view
        print("tapped")
    }
    func setupUI() {
        view.backgroundColor = Colors.lightBlue
        view.addSubviews(background,customBlueBorder,adressLabel,priceLabel,rangeLabel,nameLabel, metroIcon,locationIcon,priceIcon,viewForTapRecognizer)
        background.snp.makeConstraints { (make) in
            make.left.top.equalTo(view).offset(view.bounds.width / 23.4)
            make.right.bottom.equalTo(view).offset(-view.bounds.width / 23.4)
        }
        viewForTapRecognizer.snp.makeConstraints { (make) in
            make.left.equalTo(background.snp.left)
            make.right.equalTo(background.snp.right)
            make.bottom.equalTo(background.snp.bottom)
            make.top.equalTo(background.snp.top)
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
