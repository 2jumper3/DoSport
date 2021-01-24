//
//  CodeEntryAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/01/2021.
//

import UIKit

final class CodeEntryAssembly: Assembly {
    
    private let phoneNumber: String
    
    init(_ phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
    func makeModule() -> CodeEntryViewController {
        let viewModel = CodeEntryViewModel()
        let viewController = CodeEntryViewController(viewModel: viewModel, phoneNumber: phoneNumber)
        return viewController
    }
}
