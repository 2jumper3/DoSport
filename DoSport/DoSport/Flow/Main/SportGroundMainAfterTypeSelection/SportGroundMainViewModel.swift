//
//  SportGroundMainViewModel.swift
//  DoSport
//
//  Created by Sergey on 05.04.2021.
//

import Foundation

final class SportGroundMainViewModel {
    
    var onDidPrepareData: (([SportGround]) -> Void)?
    
    private var sportGrounds: [SportGround]? {
        didSet {
            guard let sportGrounds = sportGrounds else { return }
            
            onDidPrepareData?(sportGrounds)
        }
    }
    
    init() {
        
    }
}

//MARK: - Public methods

extension SportGroundMainViewModel {
    
    func prepareData() { //test data
        var tempSportGrounds: [SportGround] = []
        var events: [Event] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        //event 1 date
        let dateString1 = "2021-02-17T21:00:00"
        let startTimeString1 = "2021-02-17T21:00:00"
        let endTimeString1 = "2021-02-17T22:00:00"
        
        let date1 = dateFormatter.date(from: dateString1)
        let startDate1 = dateFormatter.date(from: startTimeString1)
        let endDate1 = dateFormatter.date(from: endTimeString1)
        
        //event 2 date
        let dateString2 = "2021-02-15T11:00:00"
        let startTimeString2 = "2021-02-15T11:00:00"
        let endTimeString2 = "2021-02-15T12:00:00"
        
        let date2 = dateFormatter.date(from: dateString2)
        let startDate2 = dateFormatter.date(from: startTimeString2)
        let endDate2 = dateFormatter.date(from: endTimeString2)
        
        
        
        let event = Event(
            eventID: 1,
            eventDate: date1,
            eventEndTime: endDate1,
            eventStartTime: startDate1,
            organiserID: 1,
            chatID: Chat(ID: 1, messages: [], userID: 1, userName: 1),
            members: [],
            sportGroundID: 1,
            sportType: nil
        )
        
        let event2 = Event(
            eventID: 2,
            eventDate: date2,
            eventEndTime: endDate2,
            eventStartTime: startDate2,
            organiserID: 2,
            chatID: Chat(ID: 2, messages: [], userID: 2, userName: 2),
            members: [],
            sportGroundID: 2,
            sportType: nil
        )
        
        events.append(event)
        events.append(event2)
        
        for i in 0..<19 {
            let sportGround = SportGround(
                sportGroudID: i,
                title: "SportGround title \(i)",
                address: "Address \(i)",
                city: "City \(i)",
                events: events,
                lattitude: 0.0,
                longitude: 0.0,
                sportTypes: []
            )
            tempSportGrounds.append(sportGround)
        }
        self.sportGrounds = tempSportGrounds
    }
}
