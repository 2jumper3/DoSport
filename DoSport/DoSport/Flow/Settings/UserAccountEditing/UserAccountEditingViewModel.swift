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
    
    private let userNetworkService: UserNetworkService
    
    init(userNetworkService: UserNetworkService) {
        self.userNetworkService = userNetworkService
    }
    
    func doEditUserProfile(request: UserEditDataFlow.EditUserProfile.Request) {
        self.onDidEditUserProfile?(.init(state: .loading))
        
        userNetworkService.userProfileEdit(params: request.user) { [unowned self] response in
            switch response {
            case .success:
                self.onDidEditUserProfile?(.init(state: .success))
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func doDeleteUserProfile(request: UserEditDataFlow.DeleteUserProfile.Request) {
        self.onDidDeleteUserProfile?(.init(state: .loading))
        
        userNetworkService.userProfileDelete { [unowned self] response in
            switch response {
            case .success:
                self.onDidDeleteUserProfile?(.init(state: .success))
                
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
