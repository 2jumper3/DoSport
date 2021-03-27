//
//  UserAccountEditingViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import Foundation

protocol UserAccountEditingViewModel {
    var onDidEditUserProfile: ((UserEditDataFlow.EditUserProfile.ViewModel) -> Swift.Void)? { get set }
    var onDidDeleteUserProfile: ((UserEditDataFlow.DeleteUserProfile.ViewModel) -> Swift.Void)? { get set }
     
    func doEditUserProfile(request: UserEditDataFlow.EditUserProfile.Request)
    func doDeleteUserProfile(request: UserEditDataFlow.DeleteUserProfile.Request)
}

final class UserAccountEditingViewModelImplementation: UserAccountEditingViewModel {
    
    var onDidEditUserProfile: ((UserEditDataFlow.EditUserProfile.ViewModel) -> Swift.Void)?
    var onDidDeleteUserProfile: ((UserEditDataFlow.DeleteUserProfile.ViewModel) -> Swift.Void)?
    
    private let requestsManager: RequestsManager
    
    init(requestsManager: RequestsManager) {
        self.requestsManager = requestsManager
    }
    
    func doEditUserProfile(request: UserEditDataFlow.EditUserProfile.Request) {
        self.onDidEditUserProfile?(.init(state: .loading))
        
        requestsManager.userProfileEdit(params: request.user) { [unowned self] response in
            switch response {
            case .success(let result):
                switch result {
                case .object(let user):
                    debugPrint(user)
                    self.onDidEditUserProfile?(.init(state: .success))
                case .emptyObject:
                    break
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func doDeleteUserProfile(request: UserEditDataFlow.DeleteUserProfile.Request) {
        self.onDidDeleteUserProfile?(.init(state: .loading))
        
        requestsManager.userProfileDelete { [unowned self] response in
            switch response {
            case .success(let result):
                switch result {
                case .object:
                    break
                    
                case .emptyObject:
                    self.onDidDeleteUserProfile?(.init(state: .success))
                    break
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.onDidDeleteUserProfile?(.init(state: .failed))
            }
        }
    }
}

enum UserEditDataFlow {
    
    enum EditUserProfile {
        struct Request {
            let user: DSModels.User.UserView
        }
        
        struct ViewModel {
            let state: ViewConrollerState
        }
    }
    
    enum DeleteUserProfile {
        struct Request {
            
        }
        
        struct ViewModel {
            let state: ViewConrollerState
        }
    }
    
    enum ViewConrollerState {
        case loading
        case failed
        case success
    }
}
