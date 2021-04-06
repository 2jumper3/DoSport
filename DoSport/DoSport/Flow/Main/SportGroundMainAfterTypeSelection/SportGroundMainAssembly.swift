//
//  SportGroundMainAssembly.swift
//  DoSport
//
//  Created by Sergey on 05.04.2021.
//

import Foundation

final class SportGroundMainAssembly: Assembly {
    
    private let sportTypeTitle: String
    
    init(sportTypeTitle: String) {
        self.sportTypeTitle = sportTypeTitle
    }
    
    func makeModule() -> SportGroundMainController {
        let viewModel = SportGroundMainViewModel()
        let viewController = SportGroundMainController(
            viewModel: viewModel,
            sportTypeTitle: sportTypeTitle
        )
        return viewController
    }
}
