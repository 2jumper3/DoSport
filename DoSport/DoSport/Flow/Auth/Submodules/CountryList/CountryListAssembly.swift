//
//  CountryListAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import Foundation

final class CountryListAssembly: Assembly {
    func makeModule() -> CountryListViewController {
        let viewModel = CountryListViewModel()
        let vc = CountryListViewController(viewModel: viewModel)
        return vc
    }
}
