//
//  SportGroundSelectionListAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import Foundation

final class SportGroundSelectionListAssembly: Assembly {
    
    private let completion: (DSModels.SportGround.SportGroundResponse) -> Void
    private let sportTypeTitle: String
    
    init(sportTypeTitle: String, completion: @escaping (DSModels.SportGround.SportGroundResponse) -> Void) {
        self.completion = completion
        self.sportTypeTitle = sportTypeTitle
    }
    
    func makeModule() -> SportGroundSelectionListViewController {
        let viewModel = SportGroundSelectionListViewModel()
        let viewController = SportGroundSelectionListViewController(
            viewModel: viewModel,
            sportTypeTitle: sportTypeTitle,
            completion: completion
        )
        return viewController
    }
}
