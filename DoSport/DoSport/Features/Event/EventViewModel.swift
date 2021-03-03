//
//  EventViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import Foundation

final class EventViewModel {
    
    var onDidPrepareEventData: ((Event) -> Void)?
    
    var event: Event? {
        didSet {
            guard let event = event else { return }
            onDidPrepareEventData?(event)
        }
    }
    
    init() {
        
    }
}

//MARK: - Public methods

extension EventViewModel {
    
    func prepareEventData(event: Event?) {
        self.event = event
    }
}
