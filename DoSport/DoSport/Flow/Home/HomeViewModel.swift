//
//  HomeViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

final class HomeViewModel {
    
    private let requestFactory: RequestFactory
    
    var onDidPrepareEvents: (([Event]) -> Void)?
    
    private var events: [Event] = []
    
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }
    
    func prepareEventsData() {
        let eventsRequest = requestFactory.makeGetEventsRequest()
        
        eventsRequest.getEvents(token: "") { events in
            print(events)
        }
    }
}
