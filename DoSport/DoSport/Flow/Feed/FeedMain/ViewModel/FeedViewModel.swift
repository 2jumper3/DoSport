//
//  FeedViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

final class FeedViewModel {
    
    private let eventNetworkService: EventNetworkService
    
    var onDidPrepareEventsData: (([DSModels.Event.EventView]) -> Void)?
    
    private var events: [DSModels.Event.EventView]? = [] {
        didSet {
            guard let events = events else { return }
            onDidPrepareEventsData?(events)
        }
    }
    
    init(eventNetworkService: EventNetworkService) {
        self.eventNetworkService = eventNetworkService
    }
    
    func prepareEventsData() {
        eventNetworkService.eventsGet(queryComponents: .init(creationDateTime: nil, eventID: nil, startDateTime: nil, endDateTime: nil, sportType: nil, sportGroundID: nil, organizer: nil, members: nil, description: nil, isPrivate: nil, price: nil, maximumUsers: nil, usersAmount: nil, messagesAmount: nil)  )
//        eventNetworkService.eventsGet(queryComponents: nil  )
        { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let models):
                print(models)
                self.events = models
//                completion(models)
            }
        }
    }
}
