//
//  CustomSearchBar.swift
//  DoSport
//
//  Created by MAC on 19.01.2021.
//

import UIKit

class CustomSearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: .zero)

        defaultColorSchemeSearchBar()

        textField?.backgroundColor = Colors.darkBlue
        textField?.layer.borderWidth = 1
        textField?.layer.cornerRadius = 8
        textField?.textColor = .white
        textField?.font = Fonts.sfProRegular(size: 16)
        clearBackgroundColor()
        textField?.clearButtonMode = .never
        showsCancelButton = false

        textField?.snp.makeConstraints({ (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeColorSchemeSearchBar() {
        setLeftImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysTemplate), with: 6, tintColor: Colors.mainBlue)
        textField?.layer.borderColor = Colors.mainBlue.cgColor
        textField?.attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: [NSAttributedString.Key.foregroundColor: Colors.mainBlue])
    }

    func defaultColorSchemeSearchBar() {
        setLeftImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysTemplate), with: 6, tintColor: Colors.dirtyBlue)
        textField?.layer.borderColor = Colors.dirtyBlue.cgColor
        textField?.attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: [NSAttributedString.Key.foregroundColor: Colors.dirtyBlue])
    }
}
