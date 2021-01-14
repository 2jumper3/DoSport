//
//  CodeEntryAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/01/2021.
//

import UIKit

final class CodeEntryAssembly: Assembly {
    func makeModule() -> CodeEntryViewController {
        let viewModel = CodeEntryViewModel()
        let viewController = CodeEntryViewController(viewModel: viewModel)
        return viewController
    }
}
