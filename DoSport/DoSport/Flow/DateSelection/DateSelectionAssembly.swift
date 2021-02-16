//
//  DateSelectionAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import Foundation

final class DateSelectionAssembly: Assembly {
    
    private let completion: (String) -> Void
    
    init(completion: @escaping (String) -> Void) {
        self.completion = completion
    }
    
    func makeModule() -> DateSelectionViewController {
        let viewModel = DateSelectionViewModel()
        let viewController = DateSelectionViewController(
            viewModel: viewModel,
            completion: completion
        )
        return viewController
    }
}
