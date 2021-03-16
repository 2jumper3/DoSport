//
//  EventViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import Foundation

final class EventViewModel {
    
    var onDidPrepareEventData: ((Event) -> Void)?
    
    var isCurrentUserOrganisedEvent: Bool = false
    
    var event: Event? {
        didSet {
            guard let event = event else { return }
            
            self.onDidPrepareEventData?(event)
        }
    }
    
    init(event: Event?) {
        self.event = event
        
        checkIfUserOrganised(event: event!)
    }
}

//MARK: Public API

extension EventViewModel {
    
    func checkIfUserOrganised(event: Event) {
        /// request user by `organiserID` of event. If fetched user equals to current user then return true else false
        self.isCurrentUserOrganisedEvent = true
    }
}
