//
//  SportGroundMainViewModel.swift
//  DoSport
//
//  Created by Sergey on 05.04.2021.
//

import Foundation

protocol SportGroundMainViewModelProtocol: class {
//    func doLoadEvents(request: SportGroundDataFlow.LoadEvents<[DSModels.Event.EventView]>.Request)
    func doLoadSportGrounds(request: SportGroundDataFlow.LoadSportGrounds<DSModels.SportGround.SportGroundResponse>.Request)

}

final class SportGroundMainViewModel: NSObject, SportGroundMainViewModelProtocol {
    
    var didLoadEvents: ((UserMainDataFlow.LoadEvents<[DSModels.Event.EventView]>.ViewModel) -> Swift.Void)?
    var didLoadSportGrounds: ((SportGroundDataFlow.LoadSportGrounds<[DSModels.SportGround.SportGroundResponse]>.ViewModel) -> Swift.Void)?
    
    var onDidPrepareData: (([DSModels.SportGround.SportGroundResponse]) -> Void)?
    private let sportNetworkService: SportGroundNetworkService
//    private let eventNetwkrService: EventNetworkService
    
//    func doLoadEvents(request: SportGroundDataFlow.LoadEvents<[DSModels.Event.EventView]>.Request) {
//
//        }
//
//
    func doLoadSportGrounds(request: SportGroundDataFlow.LoadSportGrounds<DSModels.SportGround.SportGroundResponse>.Request) {
        sportNetworkService.sportGroundsGet { [unowned self] response in
            switch response {
            case .success(let sportGrounds):
                self.didLoadSportGrounds?(.init(state: .success(sportGrounds)))
            case .failure(let error):
                print(error.localizedDescription)
                self.didLoadSportGrounds?(.init(state: .failed))
            }
    }
    }
    
    private var sportGrounds: [DSModels.SportGround.SportGroundResponse]? {
        didSet {
            guard let sportGrounds = sportGrounds else { return }
            
            onDidPrepareData?(sportGrounds)
        }
    }
    
    init(sportGroundNetwork: SportGroundNetworkService) {
        self.sportNetworkService = sportGroundNetwork
        super.init()
    }
}



//MARK: - Public methods

extension SportGroundMainViewModel {
    
    func prepareData() { //test data
        var tempSportGrounds: [DSModels.SportGround.SportGroundResponse] = []
        var events: [DSModels.Event.EventView] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        //event 1 date
        let dateString1 = "2021-02-17T21:00:00"
        let startTimeString1 = "2021-02-17T21:00:00"
        let endTimeString1 = "2021-02-17T22:00:00"
        
//        let date1 = dateFormatter.date(from: dateString1)
//        let startDate1 = dateFormatter.date(from: startTimeString1)
//        let endDate1 = dateFormatter.date(from: endTimeString1)
//        
        //event 2 date
        let dateString2 = "2021-02-15T11:00:00"
        let startTimeString2 = "2021-02-15T11:00:00"
        let endTimeString2 = "2021-02-15T12:00:00"
        
//        let date2 = dateFormatter.date(from: dateString2)
//        let startDate2 = dateFormatter.date(from: startTimeString2)
//        let endDate2 = dateFormatter.date(from: endTimeString2)
//
        
        
        let newEvent = DSModels.Event.EventView (
            creationDateTime: dateString1,
            eventID: 1,
            startDateTime: startTimeString2,
            endDateTime: endTimeString2,
            sportType: "Football",
            sportGroundID: 22,
            organizer: Participants(id: 1, username: "EDik", birthdayDate: "06-06-06", gender: "Male", info: "Here will be info", photoLink: ""),
            members: [],
            description: "Description",
            isPrivate: false,
            price: 100,
            maximumUsers: 25, usersAmount: 20,
            messagesAmount: 10)
        
        let newEvent2 = DSModels.Event.EventView (
            creationDateTime: dateString2,
            eventID: 1,
            startDateTime: startTimeString2,
            endDateTime: endTimeString2,
            sportType: "Basket",
            sportGroundID: 22,
            organizer: Participants(id: 1, username: "NeEdik", birthdayDate: "06-06-06", gender: "Male", info: "Here will be info", photoLink: ""),
            members: [],
            description: "SecondDesription",
            isPrivate: true,
            price: 100,
            maximumUsers: 25, usersAmount: 20,
            messagesAmount: 10)
        
        
        events.append(newEvent)
        events.append(newEvent2)
        
        for i in 0..<19 {
//            let sportGround = DSModels.SportGround.SportGroundResponse(
//                sportGroudID: i,
//                title: "SportGround title \(i)",
//                address: "Address \(i)",
//                city: "City \(i)",
//                events: events,
//                lattitude: 0.0,
//                longitude: 0.0,
//                sportTypes: []
//            )
            let sportGround2 = DSModels.SportGround.SportGroundResponse(
                sportGroundId: i,
                city: "City\(1)",
                address: "Address \(i)",
                title: "SportGround title \(i)",
                latitude: 0.0,
                longitude: 0.0,
                metroStation: "RedSquare",
                surfaceType: "Boks",
                rentPrice: 1000,
                opened: true,
                infrastructures: [],
                sportTypes: ["Any"],
                subscribers: [],
                reviews: ["Comments"],
                events: events,
                openingTime: startTimeString1,
                closedTime: endTimeString1)
            tempSportGrounds.append(sportGround2)
        }
        self.sportGrounds = tempSportGrounds
    }
}

//MARK: - DataFlow -

enum SportGroundDataFlow {
    enum LoadEvents<T> where T: Codable {
        struct Request {
//            let userID: Int
        }
        
        struct ViewModel {
            let state: ViewControllerState<T>
        }
    }
    
    enum LoadSportGrounds<T> where T: Codable {
        struct Request { }
        
        struct ViewModel {
            let state: ViewControllerState<T>
        }
    }
    
    enum ViewControllerState<T: Codable> {
        case loading
        case failed
        case success(T?)
    }
}
