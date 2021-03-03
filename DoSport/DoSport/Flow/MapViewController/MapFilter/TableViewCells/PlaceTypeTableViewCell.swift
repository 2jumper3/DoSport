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
        groundButton.translatesAutoresizingMaskIntoConstraints = false
        trainingButton.translatesAutoresizingMaskIntoConstraints = false
        studioButton.translatesAutoresizingMaskIntoConstraints = false
        clubsButton.translatesAutoresizingMaskIntoConstraints = false
        challengesButton.translatesAutoresizingMaskIntoConstraints = false
        groupButton.translatesAutoresizingMaskIntoConstraints = false

        let groupButtons = UIStackView(arrangedSubviews: [groundButton, trainingButton, studioButton,clubsButton,challengesButton,groupButton])
        contentView.addSubview(groupButtons)
        groupButtons.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.height.equalTo(100)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).priority(999)
        }
        groupButtons.spacing = 10
        groupButtons.alignment = .leading
    }
    func textAdding(text: String)  {
//        headName.text = text
    }

}


