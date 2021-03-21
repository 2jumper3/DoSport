//
//  UserAccountEditingViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import Foundation

protocol UserAccountEditingViewModel {
    var onUserProfileEditSuccess: (() -> Swift.Void)? { get set }
    var onUserProfileEditError: (() -> Swift.Void)? { get set }
     
    func userDidEditProfile(_ userData: DSUserProfileRequests.UserProfileEdit)
}

final class UserAccountEditingViewModelImplementation: UserAccountEditingViewModel {
    
    var onUserProfileEditSuccess: (() -> Void)?
    var onUserProfileEditError: (() -> Void)?
    
    private let requestsManager: RequestsManager
    
    init(requestsManager: RequestsManager) {
        self.requestsManager = requestsManager
    }
    
    func userDidEditProfile(_ userData: DSUserProfileRequests.UserProfileEdit) {
        requestsManager.userProfileEdit(params: userData) { [weak self] response in
            switch response {
            case .success(let result):
                switch result {
                case .object(let user):
                    debugPrint(user)
                    self?.onUserProfileEditSuccess?()
                case .emptyObject:
                    break
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self?.onUserProfileEditError?()
            }
        }
    }
}
