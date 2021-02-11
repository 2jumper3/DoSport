//
//  SelectionCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

final class SelectionCell: UITableViewCell {
    
    private(set) var myTitleLabel: UILabel = {
        $0.textColor = Colors.dirtyBlue
        $0.font = Fonts.sfProRegular(size: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var myImageView: UIImageView = {
        $0.image = Icons.EventCreate.next
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(myTitleLabel, myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.height.equalToSuperview().multipliedBy(0.366)
        }
        
        myImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(12)
            $0.height.equalTo(myTitleLabel.snp.height).multipliedBy(0.7)
            $0.width.equalTo(myImageView.snp.height).multipliedBy(0.7)
        }
    }
    
    // Immitate cell selection when user did tap cell
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIViewPropertyAnimator(duration: 0.2, curve: .linear) { [self] in
            contentView.backgroundColor = Colors.dirtyBlue
            myTitleLabel.textColor = .white
        }.startAnimation()
    }
    
    // Immitate cell deselection when user did untap cell
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIViewPropertyAnimator(duration: 0.35, curve: .linear) { [self] in
            contentView.backgroundColor = Colors.darkBlue
            myTitleLabel.textColor = Colors.dirtyBlue
        }.startAnimation()
    }
    
    // Immitate cell deselection when user did untap cell after move
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        UIViewPropertyAnimator(duration: 0.35, curve: .linear) { [self] in
            contentView.backgroundColor = Colors.darkBlue
            myTitleLabel.textColor = Colors.dirtyBlue
        }.startAnimation()
    }
}

