//
//  SportTypeListAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import Foundation

final class SportTypeListAssembly: Assembly {
    
    private let completion: (String) -> Void
    
    init(completion: @escaping (String) -> Void) {
        self.completion = completion
    }
    
    func makeModule() -> SportTypeListViewController {
        let viewModel = SportTypeListViewModel()
        let viewController = SportTypeListViewController(viewModel: viewModel, completion: completion)
        return viewController
    }
}
