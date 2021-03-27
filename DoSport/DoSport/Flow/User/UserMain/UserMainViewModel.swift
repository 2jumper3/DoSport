//
//  UserMainViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import Foundation

protocol UserMainViewModelProtocol: class {
    func doLoadEvents(request: UserMainDataFlow.LoadEvents<[DSModels.Event.EventView]>.Request)
    func doLoadSportGrounds(request: UserMainDataFlow.LoadSportGrounds<DSModels.SportGround.SportGroundResponse>.Request)
}

final class UserMainViewModel: NSObject, UserMainViewModelProtocol {
    
    var didLoadEvents: ((UserMainDataFlow.LoadEvents<[DSModels.Event.EventView]>.ViewModel) -> Swift.Void)?
    var didLoadSportGrounds: ((UserMainDataFlow.LoadEvents<DSModels.SportGround.SportGroundResponse>.ViewModel) -> Swift.Void)?
    
    private let requestsManager: RequestsManager
    
    init(requestsManager: RequestsManager) {
        self.requestsManager = requestsManager
        super.init()
    }
    
    func doLoadEvents(request: UserMainDataFlow.LoadEvents<[DSModels.Event.EventView]>.Request) {
        requestsManager.userGetOwnedEvents(queryItems: .init(id: request.userID)) { [unowned self] response in
            switch response {
            case .success(let result):
                switch result {
                case .object(let events):
                    self.didLoadEvents?(.init(state: .success(events)))
                case .emptyObject:
                    break
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.didLoadEvents?(.init(state: .failed))
            }
        }
    }
    
    func doLoadSportGrounds(
        request: UserMainDataFlow.LoadSportGrounds<DSModels.SportGround.SportGroundResponse>.Request
    ) {
        
    }
}

//MARK: - DataFow -

enum UserMainDataFlow {
    enum LoadEvents<T> where T: Codable {
        struct Request {
            let userID: Int
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
