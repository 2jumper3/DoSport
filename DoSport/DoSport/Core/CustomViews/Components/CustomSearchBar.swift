//
//  Customsearchbar.swift
//  DoSport
//
//  Created by MAC on 03.03.2021.
//

import UIKit

final class CustomSearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setColorScheme(main: false)

        textField?.backgroundColor = Colors.darkBlue
        textField?.layer.borderWidth = 1
        textField?.layer.cornerRadius = 8
        textField?.textColor = .white
        textField?.font = Fonts.sfProRegular(size: 16)
        clearBackgroundColor()
        textField?.clearButtonMode = .never
        showsCancelButton = false

        textField?.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setColorScheme(main: Bool) {
        if main {
            setLeftImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysTemplate), with: 6, tintColor: Colors.mainBlue)
            textField?.layer.borderColor = Colors.mainBlue.cgColor
            textField?.attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: [NSAttributedString.Key.foregroundColor: Colors.mainBlue])
        } else {
            setLeftImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysTemplate), with: 6, tintColor: Colors.dirtyBlue)
            textField?.layer.borderColor = Colors.dirtyBlue.cgColor
            textField?.attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: [NSAttributedString.Key.foregroundColor: Colors.dirtyBlue])
        }
    }
}
