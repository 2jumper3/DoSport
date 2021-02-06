//
//  EventAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import Foundation

final class EventAssembly: Assembly {
    
    func makeModule() -> EventViewController {
        let viewModel = EventViewModel()
        let viewController = EventViewController(viewModel: viewModel)
        return viewController
    }
}
