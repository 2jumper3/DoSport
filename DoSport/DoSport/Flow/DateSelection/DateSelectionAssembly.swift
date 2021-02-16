//
//  DateSelectionAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import Foundation

final class DateSelectionAssembly: Assembly {
    
    func makeModule() -> DateSelectionViewController {
        let viewModel = DateSelectionViewModel()
        let viewController = DateSelectionViewController(viewModel: viewModel)
        return viewController
    }
}
