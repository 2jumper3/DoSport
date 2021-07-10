//
//  EventViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import Foundation

final class EventViewModel {
    
    var onDidPrepareEventData: ((DSModels.Event.EventView) -> Void)?
    
    var isCurrentUserOrganisedEvent: Bool = false
    
    var event: DSModels.Event.EventView? {
        didSet {
            guard let event = event else { return }
            
            self.onDidPrepareEventData?(event)
        }
    }
    
    init(event: DSModels.Event.EventView?) {
        self.event = event
        
        checkIfUserOrganised(event: event!)
    }
}

//MARK: Public API

extension EventViewModel {
    
    func checkIfUserOrganised(event: DSModels.Event.EventView) {
        /// request user by `organiserID` of event. If fetched user equals to current user then return true else false
        self.isCurrentUserOrganisedEvent = true
    }
}
