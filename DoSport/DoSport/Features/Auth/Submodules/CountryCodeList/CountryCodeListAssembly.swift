//
//  CountryCodeListAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import Foundation

final class CountryCodeListAssembly: Assembly {
    
    func makeModule() -> CountryCodeListViewController {
        let viewModel = CountryCodeListViewModel()
        let vc = CountryCodeListViewController(viewModel: viewModel)
        return vc
    }
}
