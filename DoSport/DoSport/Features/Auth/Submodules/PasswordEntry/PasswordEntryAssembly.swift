//
//  PasswordEntryAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

final class PasswordEntryAssembly: Assembly {
    
    func makeModule() -> PasswordEntryViewController {
        let viewModel = PasswordEntryViewModel()
        let viewController = PasswordEntryViewController(viewModel: viewModel)
        return viewController
    }
}
