//
//  UserSubscriberListViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 24/03/2021.
//

import Foundation

protocol UserSubscriberListViewModelProtocol: class {
    var onDidLoadSubscribes: ((UserSubscriberListDataFlow.LoadSubscribes.ViewModel) -> Swift.Void)? { get set }
    var onDidLoadSubscriptions: ((UserSubscriberListDataFlow.LoadSubscriptions.ViewModel) -> Swift.Void)? { get set }
    
    func doLoadSubscribers(request: UserSubscriberListDataFlow.LoadSubscribes.Request)
    func doLoadSubscriptions(request: UserSubscriberListDataFlow.LoadSubscriptions.Request)
}

final class UserSubscriberListViewModel: NSObject, UserSubscriberListViewModelProtocol {
    
    var onDidLoadSubscribes: ((UserSubscriberListDataFlow.LoadSubscribes.ViewModel) -> Swift.Void)?
    var onDidLoadSubscriptions: ((UserSubscriberListDataFlow.LoadSubscriptions.ViewModel) -> Swift.Void)?
    
    private let userNetworkService: UserNetworkService
    
    init(userNetworkService: UserNetworkService) {
        self.userNetworkService = userNetworkService
        super.init()
    }

    func doLoadSubscribers(request: UserSubscriberListDataFlow.LoadSubscribes.Request) {
        self.onDidLoadSubscribes?(.init(state: .loading))
        
        userNetworkService.userGetSubscribers { response in
            switch response {
            case .success(let result):
                switch result {
                case .object(let data):
                    debugPrint(data)
                    self.onDidLoadSubscribes?(.init(state: .success(data)))
                    break
                case .emptyObject:
                    break
                }
            case .failure(let error):
                debugPrint(error)
                self.onDidLoadSubscribes?(.init(state: .failed))
            }
        }
    }
    
    func doLoadSubscriptions(request: UserSubscriberListDataFlow.LoadSubscriptions.Request) {
        self.onDidLoadSubscriptions?(.init(state: .loading))
        
        userNetworkService.userGetSubscriptions { response in
            switch response {
            case .success(let result):
                switch result {
                case .object(let data):
                    debugPrint(data)
                    self.onDidLoadSubscriptions?(.init(state: .success(data)))
                    break
                case .emptyObject:
                    break
                }
            case .failure(let error):
                debugPrint(error)
                self.onDidLoadSubscribes?(.init(state: .failed))
            }
        }
    }
}

enum UserSubscriberListDataFlow {
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

