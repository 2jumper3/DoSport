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
    
    weak var viewController: UserMainControllerProtocol?
    
    private let requestsManager: RequestsManager
    
    init(requestsManager: RequestsManager) {
        self.requestsManager = requestsManager
        super.init()
    }
    
    func doLoadEvents(request: UserMainDataFlow.LoadEvents<[DSModels.Event.EventView]>.Request) {
        viewController?.displayEvents(viewModel: .init(state: .loading))
        
        requestsManager.userGetOwnedEvents(queryItems: .init(id: request.userID)) { [weak self] response in
            switch response {
            case .success(let result):
                switch result {
                case .object(let events):
                    self?.viewController?.displayEvents(viewModel: .init(state: .success(events)))
                case .emptyObject:
                    break
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func doLoadSportGrounds(
        request: UserMainDataFlow.LoadSportGrounds<DSModels.SportGround.SportGroundResponse>.Request
    ) {
        viewController?.displayEvents(viewModel: .init(state: .loading))
        
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
