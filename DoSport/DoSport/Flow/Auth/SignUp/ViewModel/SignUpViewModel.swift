//
//  SignUpViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import Foundation

protocol SignUpViewModelProtocol: class {
    var onSendingSignUpDataToServer: ((SignUpViewModel.ViewState) -> Swift.Void)? { get set }
    
    func doSendSignUpDataToServer()
    
    func goToFeedModuleRequest()
    func goBackRequest()
}

final class SignUpViewModel: SignUpViewModelProtocol {
    
    enum ViewState {
        case loading
        case failed
        case success
    }
    
    var onSendingSignUpDataToServer: ((ViewState) -> Void)?
    
    private weak var coordinator: SignUpCoordinator?
    
    init(coordinator: SignUpCoordinator) {
        self.coordinator = coordinator
    }
    
    func doSendSignUpDataToServer() {
        
    }
    
    func goToFeedModuleRequest() {
        
    }
    
    func goBackRequest() {
    
    }
}
