//
//  SportTypeGridAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

final class SportTypeGridAssembly: Assembly {
    
    func makeModule() -> SportTypeGridViewController {
        let viewModel = SportTypeGridViewModel()
        let vc = SportTypeGridViewController(viewModel: viewModel)
        return vc
    }
}
