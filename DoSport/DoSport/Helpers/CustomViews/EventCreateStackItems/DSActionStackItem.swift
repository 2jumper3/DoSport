//
//  DSActionStackItem.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit
import SnapKit

final class DSActionStackItem: UIView {
    
    private let topSeperatorView = DSSeparatorView()
    
    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = Colors.dirtyBlue
        $0.font = Fonts.sfProRegular(size: 18)
        return $0
    }(UILabel())
    
    private lazy var imageView: UIImageView = {
        $0.image = Icons.EventCreate.next
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())


    //MARK: - Init
    
    init(text: String) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = text
        
        addSubviews(
            topSeperatorView,
            titleLabel,
            imageView
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        topSeperatorView.snp.makeConstraints {
            $0.top.width.centerX.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.height.equalToSuperview().multipliedBy(0.366)
        }
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(12)
            $0.height.equalTo(titleLabel.snp.height)
            $0.width.equalTo(imageView.snp.height).multipliedBy(0.7)
        }
    }
}
