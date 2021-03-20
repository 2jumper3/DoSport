//
//  FeedViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

final class FeedViewModel {
    
    private let requestFactory: RequestsManager
    
    var onDidPrepareEventsData: (([Event]) -> Void)?
    
    private var events: [Event]? = [] {
        didSet {
            guard let events = events else { return }
            onDidPrepareEventsData?(events)
        }
    }
    
    init(requestFactory: RequestsManager) {
        self.requestFactory = requestFactory
    }
    
    func prepareEventsData() {
        requestFactory.eventsGet { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let models):
                print(models)
            }
        }
        
        var membersArray: [Member] = []
        for i in 1...11 {
            let member = Member(
                userID: 1,
                eventID: 1,
                userStatus: "SomeStatus - \(i)"
            )
            membersArray.append(member)
        }
        
        let sportType = Sport(type: .basketball)
        
        var messagesArray: [Message] = []
        for i in 1...15 {
            let message1 = Message(
                eventId: 1,
                id: 1,
                text: "Some sample comment \(i)",
                userId: 1,
                userName: "Kamol \(i)",
                createdDate: Date(timeIntervalSinceNow: TimeInterval())
            )
            messagesArray.append(message1)
        }
        
        let chat = Chat(
            ID: 1,
            messages: messagesArray,
            userID: nil,
            userName: nil
        )
        
        var customEvents: [Event] = []
        
        for i in 1...10 {
            let event = Event(
                eventID: i,
                eventDate: Date.init(),
                eventEndTime: Date.init(),
                eventStartTime: Date.init(),
                organiserID: i,
                chatID: chat,
                members: membersArray,
                sportGroundID: i,
                sportType: sportType
            )
            customEvents.append(event)
        }

        self.events = customEvents
    }
}
