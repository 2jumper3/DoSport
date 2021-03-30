//
//  EventCreateAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import Foundation

final class EventCreateAssembly: Assembly {
    
    func makeModule() -> EventCreateViewController {
        let viewModel = EventCreateViewModel()
        let viewController = EventCreateViewController(viewModel: viewModel)
        return viewController
    }
}
