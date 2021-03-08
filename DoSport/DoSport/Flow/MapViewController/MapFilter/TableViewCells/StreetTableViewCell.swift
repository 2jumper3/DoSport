//
//  StreetTableViewCell.swift
//  DoSport
//
//  Created by Sergey on 05.03.2021.
//

import UIKit

class StreetTableViewCell: UITableViewCell {
    
    //MARK: - UI
    private lazy var headName: UILabel = {
        let label = UILabel()
        label.text = "На улице"
        label.textColor = Colors.lightBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var switcher: DSSwitch = {
        let switcher = DSSwitch()
        switcher.isUserInteractionEnabled = true
        return switcher
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
        contentView.addSubview(switcher)
        headName.translatesAutoresizingMaskIntoConstraints = false
        switcher.translatesAutoresizingMaskIntoConstraints = false

        headName.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.height.equalTo(60)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).priority(999)
        }
        switcher.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(-16)
        }
    }
    
    func textAdding(text: String)  {
        headName.text = text
    }

}

