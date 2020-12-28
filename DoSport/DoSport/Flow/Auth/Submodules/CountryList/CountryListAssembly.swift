//
//  CountryListAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import Foundation

final class CountryListAssembly: Assembly {
    func makeModule() -> CountryListViewController {
        let vc = CountryListViewController()
        return vc
    }
}
