//
//  UserProfileEditingViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import Foundation

protocol UserProfileEditingViewModelProtocol {
    var onDidEditUserProfile: ((UserProfileEditingViewModel.ViewState) -> Swift.Void)? { get set }
    var onDidDeleteUserProfile: ((UserProfileEditingViewModel.ViewState) -> Swift.Void)? { get set }
    var onDidSignOut: ((UserProfileEditingViewModel.ViewState) -> Swift.Void)? { get set }
     
    func doEditUserProfile(newUserData user: DSModels.User.UserView)
    func doDeleteUserProfile()
    func doSignOut()
}

final class UserProfileEditingViewModel: UserProfileEditingViewModelProtocol {
    
    typealias Dependencies = UserAccountEditingServices
    
    enum ViewState {
        case loading
        case failed
        case success
    }
    
    var onDidEditUserProfile: ((UserProfileEditingViewModel.ViewState) -> Swift.Void)?
    var onDidDeleteUserProfile: ((UserProfileEditingViewModel.ViewState) -> Swift.Void)?
    var onDidSignOut: ((ViewState) -> Void)?
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func doSignOut() {
        self.onDidSignOut?(.loading)
        
        self.dependencies.userAccountService.logOut()
        self.onDidSignOut?(.success)
    }
    
    func doEditUserProfile(newUserData user: DSModels.User.UserView) {
        self.onDidEditUserProfile?(.loading)
        
        dependencies.userNetworkService.userProfileEdit(params: user) { [unowned self] response in
            switch response {
            case .success:
                self.onDidEditUserProfile?(.success)
                
            case .failure:
                self.onDidEditUserProfile?(.failed)
            }
        }
    }
    
    func doDeleteUserProfile() {
        self.onDidDeleteUserProfile?(.loading)
        
        dependencies.userNetworkService.userProfileDelete { [unowned self] response in
            switch response {
            case .success:
                self.dependencies.userAccountService.logOut()
                self.onDidDeleteUserProfile?(.success)

            case .failure:
                self.onDidDeleteUserProfile?(.failed)
            }
        }
    }
}
