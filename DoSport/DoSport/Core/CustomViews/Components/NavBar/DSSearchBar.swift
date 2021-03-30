//
//  DSSearchBar.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import UIKit

final class DSSearchBar: UISearchBar {
    
    enum State {
        case active
        case notActive
    }
    
    var state: State = .notActive {
        didSet {
            setState()
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        layer.cornerRadius = 8
        layer.borderWidth = 1.5
        layer.borderColor = Colors.mainBlue.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        
        if let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.textColor = .white
            textFieldInsideSearchBar.backgroundColor = Colors.darkBlue
            
            let textFieldInsideSearchBarLabel = textFieldInsideSearchBar.value(forKey: "placeholderLabel") as? UILabel
            textFieldInsideSearchBarLabel?.textColor = Colors.mainBlue
            
            if let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {
                glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
                glassIconView.tintColor = Colors.mainBlue
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Public methods
extension DSSearchBar {
    
    func bind(state: State) {
        self.state = state
    }
}

//MARK: - Private methods
private extension DSSearchBar {
    
    func setState() {
        switch self.state {
        case .active:
            placeholder = Texts.CountryList.search
        case .notActive:
            placeholder = ""
        }
    }
}
