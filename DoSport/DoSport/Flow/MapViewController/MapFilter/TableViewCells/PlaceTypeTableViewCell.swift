//
//  PlaceTypeTableViewCell.swift
//  DoSport
//
//  Created by Sergey on 25.02.2021.
//

import UIKit

class PlaceTypeTableViewCell: UITableViewCell {
    
    //MARK: - UI
    private lazy var groundButton = FeedFilterButton(title: Texts.PlaceTypeTableViewCell.ground, state: .notSelected)
    private lazy var trainingButton = FeedFilterButton(title: Texts.PlaceTypeTableViewCell.training, state: .notSelected)
    private lazy var studioButton = FeedFilterButton(title: Texts.PlaceTypeTableViewCell.studio, state: .notSelected)
    private lazy var clubsButton = FeedFilterButton(title: Texts.PlaceTypeTableViewCell.clubs, state: .notSelected)
    private lazy var challengesButton = FeedFilterButton(title: Texts.PlaceTypeTableViewCell.challenges, state: .notSelected)
    private lazy var groupButton = FeedFilterButton(title: Texts.PlaceTypeTableViewCell.group, state: .notSelected)


    
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
        contentView.addSubviews([groundButton, trainingButton, studioButton,clubsButton,challengesButton,groupButton])
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

}
