//
//  SignUpViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import Foundation

protocol SignUpViewModelProtocol: class {
    var onDidUploadSignUpDataToServer: ((SignUpViewModel.ViewState) -> Swift.Void)? { get set }
    
    func doUploadSignUpDataToServer()
}

final class SignUpViewModel: SignUpViewModelProtocol {
    
    enum ViewState {
        case loading
        case failed
        case success
    }
    
    var onDidChangeButtonState: (() -> Void)?
    var onDidUploadSignUpDataToServer: ((ViewState) -> Void)?
    
//    private let model: SignUpModel
//    private let requestsManager: RequestsManager
    
    init(/*model: SignUpModel, requestsManager: RequestsManager*/) {
//        self.model = model
//        self.requestsManager = requestsManager
    }
    
    func doUploadSignUpDataToServer() {
        
    }
}
