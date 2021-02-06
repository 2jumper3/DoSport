//
//  EventViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import Foundation

final class EventViewModel {
    
    var onDidPrepareEventData: ((Event) -> Void)?
    var onDidPrepareMembersData: (([Member]) -> Void)?
    
    var event: Event? {
        didSet {
            guard let event = event else { return }
            onDidPrepareEventData?(event)
        }
    }
    
    var members: [Member]? {
        didSet {
            guard let members = members else { return }
            onDidPrepareMembersData?(members)
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
    
    func prepareChatData() {
        
    }
}
