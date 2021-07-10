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
                
        let groupButtons = UIStackView(arrangedSubviews: [groundButton, trainingButton])
        contentView.addSubview(groupButtons)
        groupButtons.spacing = 10
        groupButtons.alignment = .center
        groupButtons.axis = .horizontal
        groundButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
        
        trainingButton.snp.makeConstraints {
            $0.width.equalTo(165)
            $0.height.equalTo(40)
        }
        groupButtons.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.height.equalTo(60)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.bottom.equalTo(contentView.snp.bottom).priority(999)
        }
    }
    
    func textAdding(text: String)  {
//        headName.text = text
    }
}


