//
//  DateSelectionAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import Foundation

final class DateSelectionAssembly: Assembly {
    
    private let completion: (String) -> Void
    private let sportGround: SportGround
    
    init(
        sportGround: SportGround,
        completion: @escaping (String) -> Void
    ) {
        self.completion = completion
        self.sportGround = sportGround
    }
    
    func makeModule() -> DateSelectionViewController {
        let viewModel = DateSelectionViewModel()
        let viewController = DateSelectionViewController(
            viewModel: viewModel,
            sportGround: sportGround,
            completion: completion
        )
        return viewController
    }
}
