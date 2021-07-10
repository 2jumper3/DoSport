//
//  SportGroundDetailViewModel.swift
//  DoSport
//
//  Created by Sergey on 28.05.2021.
//

import UIKit


protocol SportGroundDetailViewModelProtocol: class {
    var onDidLoadSubscribes: ((SportGroundDetailDataFlow.LoadSubscribes.ViewModel) -> Swift.Void)? { get set }
    var onDidLoadSubscriptions: ((SportGroundDetailDataFlow.LoadSubscriptions.ViewModel) -> Swift.Void)? { get set }
    
    func doLoadSubscribers(request: SportGroundDetailDataFlow.LoadSubscribes.Request)
    func doLoadSubscriptions(request: SportGroundDetailDataFlow.LoadSubscriptions.Request)
}

final class SportGroundDetailViewModel: NSObject, SportGroundDetailViewModelProtocol {
    
    var onDidLoadSubscribes: ((SportGroundDetailDataFlow.LoadSubscribes.ViewModel) -> Swift.Void)?
    var onDidLoadSubscriptions: ((SportGroundDetailDataFlow.LoadSubscriptions.ViewModel) -> Swift.Void)?
    
    private let userNetworkService: UserNetworkService
    
    init(userNetworkService: UserNetworkService) {
        self.userNetworkService = userNetworkService
        super.init()
    }

    func doLoadSubscribers(request: SportGroundDetailDataFlow.LoadSubscribes.Request) {
        self.onDidLoadSubscribes?(.init(state: .loading))
        
        userNetworkService.userGetSubscribers { [unowned self] response in
            switch response {
            case .success(let responseData):
                self.onDidLoadSubscribes?(.init(state: .success(responseData)))
                
            case .failure:
                self.onDidLoadSubscribes?(.init(state: .failed))
            }
        }
    }
    
    func doLoadSubscriptions(request: SportGroundDetailDataFlow.LoadSubscriptions.Request) {
        self.onDidLoadSubscriptions?(.init(state: .loading))
        
        userNetworkService.userGetSubscriptions { [unowned self] response in
            switch response {
            case .success(let responseData):
                self.onDidLoadSubscriptions?(.init(state: .success(responseData)))
                
            case .failure:
                self.onDidLoadSubscribes?(.init(state: .failed))
            }
        }
    }
}

enum SportGroundDetailDataFlow {
    enum LoadSubscribes {
        struct Request { }
        
        struct ViewModel {
            let state: ViewControllerState
        }
    }
    
    enum LoadSubscriptions {
        struct Request { }
        
        struct ViewModel {
            let state: ViewControllerState
        }
    }
    
    enum ViewControllerState {
        case loading
        case failed
        case success([DSModels.User.UserView])
    }
}

