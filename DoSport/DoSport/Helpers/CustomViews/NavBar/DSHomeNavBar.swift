//
//  DSHomeNavBar.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/01/2021.
//

import UIKit
import SnapKit

final class DSHomeNavBar: UIView {
    
    // to create new event
    
    private(set) lazy var createEventButton: UIButton = {
        $0.setImage(Icons.Home.plus, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .white
        return $0
    }(UIButton(type: .system))
    
    // home screen navBar title
    
    private let titleLabel: UILabel = {
        $0.text = Texts.Home.title
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = Fonts.sfProRegular(size: 18)
        return $0
    }(UILabel())
    
    // expands navBar width in navigationItem beyond standard titleView
    
    override internal var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.darkBlue
        
        addSubviews(createEventButton, titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints {
            $0.height.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(25)
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        createEventButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(0)
            $0.height.centerY.equalToSuperview()
            $0.width.equalTo(snp.height).multipliedBy(1.2)
        }
    }
}


