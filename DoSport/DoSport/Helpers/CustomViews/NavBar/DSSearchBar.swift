//
//  DSSearchBar.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import UIKit

final class DSSearchBar: UISearchBar, UISearchBarDelegate {
    
    private enum State {
        case active
        case notActive
    }
    
    init() {
        super.init(frame: .zero)

        self.placeholder = "Search"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
