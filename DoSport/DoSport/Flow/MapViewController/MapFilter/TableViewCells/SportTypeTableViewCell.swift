//
//  GeneralTableViewCell.swift
//  DoSport
//
//  Created by Sergey on 16.02.2021.
//

import UIKit
class SportTypeTableViewCell: UITableViewCell {
    
    //MARK: - UI
    private lazy var headName: UILabel = {
        let label = UILabel()
        label.text = "Виды спорта"
        label.textColor = Colors.lightBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var arrowImage: UIImageView = {
        let view = UIImageView(image: Icons.image(named: "Arrow"))
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupUI() {
        contentView.backgroundColor = Colors.darkBlue
        contentView.addSubview(headName)
        contentView.addSubview(arrowImage)
        headName.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.translatesAutoresizingMaskIntoConstraints = false

        headName.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.height.equalTo(60)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).priority(999)
        }
        arrowImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(-16)
            make.height.equalTo(16)
            make.width.equalTo(8.8)
        }
    }
    
    func textAdding(text: String)  {
        headName.text = text
    }

}
