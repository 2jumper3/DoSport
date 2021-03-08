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
    //MARK: - Will be added in next updates
//    private lazy var clubsButton = FeedFilterButton(title: Texts.PlaceTypeTableViewCell.clubs, state: .notSelected)
//    private lazy var challengesButton = FeedFilterButton(title: Texts.PlaceTypeTableViewCell.challenges, state: .notSelected)
//    private lazy var groupButton = FeedFilterButton(title: Texts.PlaceTypeTableViewCell.group, state: .notSelected)
    
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
        //MARK: - Will be added in next updates
//        clubsButton.translatesAutoresizingMaskIntoConstraints = false
//        challengesButton.translatesAutoresizingMaskIntoConstraints = false
//        groupButton.translatesAutoresizingMaskIntoConstraints = false
                
        let groupButtons = UIStackView(arrangedSubviews: [groundButton, trainingButton])//,clubsButton,challengesButton,groupButton])
        contentView.addSubview(groupButtons)
        groundButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
        
        trainingButton.snp.makeConstraints {
            $0.width.equalTo(165)
            $0.height.equalTo(40)
        }
    
        groupButtons.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.top.equalTo(contentView.snp.top).offset(10)
        }
        
        groupButtons.spacing = 10
        groupButtons.alignment = .center
        contentView.addSubviews(studioButton)
        studioButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
            $0.left.equalTo(groundButton.snp.left)
            $0.top.equalTo(trainingButton.snp.bottom).offset(10)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-10).priority(999)
        }
        
    }
    
    func textAdding(text: String)  {
//        headName.text = text
    }

}


