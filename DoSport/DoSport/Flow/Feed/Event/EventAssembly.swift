//
//  EventAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import Foundation

final class EventAssembly: Assembly {
    
    let event: Event
    
    init(event: Event) {
        self.event = event
    }
    
    func makeModule() -> EventViewController {
        let viewModel = EventViewModel(event: event)
        let viewController = EventViewController(
            viewModel: viewModel,
            event: event,
            isCurrentUserOrganisedEvent: viewModel.isCurrentUserOrganisedEvent
        )
        return viewController
    }
}
