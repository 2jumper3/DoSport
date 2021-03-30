//
//  FeedViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

final class FeedViewModel {
    
    private let eventNetworkService: EventNetworkService
    
    var onDidPrepareEventsData: (([Event]) -> Void)?
    
    private var events: [Event]? = [] {
        didSet {
            guard let events = events else { return }
            onDidPrepareEventsData?(events)
        }
    }
    
    init(eventNetworkService: EventNetworkService) {
        self.eventNetworkService = eventNetworkService
    }
    
    func prepareEventsData() {
        eventNetworkService.eventsGet(queryComponents: .init(fromDate: nil,
                                                        organiserID: nil,
                                                        sportGroundID: nil,
                                                        sportTypeID: nil,
                                                        toDate: nil)) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let models):
                print(models)
            }
        }
    }
}
