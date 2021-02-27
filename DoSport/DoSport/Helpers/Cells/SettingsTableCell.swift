//
//  SettingsTableCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import UIKit

final class SettingsTableCell: UITableViewCell {
    
    struct ViewData {
        let icon: UIImage?
        let title: String?
    }
    
    //MARK: Outlets
    
    private let nextIconImageView: UIImageView = {
        $0.image = Icons.Settings.next
        $0.setImageColor(color: Colors.dirtyBlue)
        return $0
    }(UIImageView())

    
    //MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Colors.darkBlue
        selectionStyle = .none
        separatorInset = .init(top: 0, left: 40, bottom: 0, right: 0)
        contentView.addSubviews(nextIconImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        removeSectionSeparators()
        
        guard let imageView = self.imageView, let textLabel = self.textLabel else { return }
        
        imageView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(imageView.snp.height)
        }
        
        textLabel.snp.makeConstraints {
            $0.height.centerY.equalToSuperview()
            $0.left.equalTo(imageView.snp.right).offset(16)
        }
        
        nextIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.35)
            $0.width.equalTo(nextIconImageView.snp.height).multipliedBy(0.55)
        }
    }
}

//MARK: Public API

extension SettingsTableCell {
    
    func bind(with data: SettingsTableCell.ViewData) {
        imageView?.image = data.icon
        imageView?.setImageColor(color: .white)
        textLabel?.text = data.title
        textLabel?.textColor = .white
    }
}
