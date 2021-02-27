//
//  DSUserMainNavBar.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import UIKit

protocol DSUserMainNavBarDelegate: class {
    func settingsButtonClicked()
}

final class DSUserMainNavBar: UIView {
    
    weak var delegate: DSUserMainNavBarDelegate?
     
    // MARK: Outlets
    
    private lazy var settingsEventButton: UIButton = {
        $0.setImage(Icons.UserMain.settings, for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(handleSettingsButton))
        $0.setImage(Icons.UserMain.settings, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .white
        return $0
    }(UIButton(type: .system))
    
    private let titleLabel: UILabel = {
        $0.text = Texts.Feed.title
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = Fonts.sfProRegular(size: 24)
        return $0
    }(UILabel())
    
    /// expands navBar width in navigationItem beyond standard titleView
    override internal var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    //MARK: Init
    
    init(userName: String? = "Юзернейм") {
        super.init(frame: .zero)
        
        self.titleLabel.text = userName
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.darkBlue
        
        settingsEventButton.addTarget(self, action: #selector(handleSettingsButton))
        
        addSubviews(settingsEventButton, titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints {
            $0.height.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
        }
        
        settingsEventButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
            $0.width.equalTo(settingsEventButton.snp.height)
        }
    }
}

//MARK: Private API

@objc private extension DSUserMainNavBar {
    
    func handleSettingsButton() {
        delegate?.settingsButtonClicked()
    }
}



