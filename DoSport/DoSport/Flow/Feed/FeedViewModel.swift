//
//  FeedViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

final class FeedViewModel {
    
    private let requestFactory: RequestFactory
    
    var onDidPrepareEventsData: (([Event]) -> Void)?
    
    private var events: [Event]? = [] {
        didSet {
            guard let events = events else { return }
            onDidPrepareEventsData?(events)
        }
    }
    
    init(requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
    }
    
    func prepareEventsData() {
//        let eventsRequest = requestFactory.makeGetEventsRequest()
//
//        eventsRequest.getEvents(token: "") { events in
//            print(events)
//        }
        
        let member1 = Member(
            userID: 1,
            eventID: 1,
            userStatus: "SomeStatus"
        )
        
        let member2 = Member(
            userID: 2,
            eventID: 1,
            userStatus: "SomeStatus"
        )
        
        let members: [Member] = [member1, member2]
        
        let sportType = Sport(type: .basketball)
        
        var count = 0
        var messagesArray: [Message] = []
        
        for _ in 1...15 {
            let message1 = Message(
                eventId: 1,
                id: 1,
                text: "Damn so boring really \(count)",
                userId: 1,
                userName: "Kamol \(count)",
                createdDate: Date(timeIntervalSinceNow: TimeInterval())
            )
            messagesArray.append(message1)
            count += 1
        }
        
        let chat = Chat(
            ID: 1,
            messages: messagesArray,
            userID: nil,
            userName: nil
        )
        
        let event1 = Event(
            eventID: 1,
            eventDate: Date.init(),
            eventEndTime: Date.init(),
            eventStartTime: Date.init(),
            organiserID: 1,
            chatID: chat,
            members: members,
            sportGroundID: 1,
            sportType: sportType
        )
        
        let event2 = Event(
            eventID: 2,
            eventDate: Date.init(),
            eventEndTime: Date.init(),
            eventStartTime: Date.init(),
            organiserID: 2,
            chatID: chat,
            members: members,
            sportGroundID: 2,
            sportType: sportType
        )
        
        let customEvents = [event1, event2]
        self.events = customEvents
    }
}
