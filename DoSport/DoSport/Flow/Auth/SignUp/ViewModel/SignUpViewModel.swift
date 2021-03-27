//
//  SignUpViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import Foundation

class SignUpRequestClass { // TODO: temp solution
    let network = NetworkManagerImplementation.shared
    
    struct SignUpRequest: Codable {
        let username: String
        let password: String
        let passwordConfirm: String
    }
    
    struct SignUpResponse: Codable {
        let id: Int?
        let username: String?
        let birthdayDate: String?
        let gender: String?
        let info: String?
        let photoLink: String?
    }
    
    func signUpRequests(completion: @escaping (DataHandler<SignUpResponse>) -> Void) {
        let signUpData = SignUpRequest(username: "kamol", password: "kamol_uk", passwordConfirm: "kamol_uk")
        let endpoint = SignUpEndpoint.login
        network.makeRequest(endpoint: endpoint, bodyObject: signUpData, completion: completion)
    }
}

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
        
        if !DSSharedData.shared.isLoggedIn {
            let network = SignUpRequestClass()
            network.signUpRequests { response in
                switch response {
                
                case .success(let responseData):
                    let userData = DSModels.User.UserView(
                        id: responseData.id,
                        username: responseData.username,
                        avatarPhoto: nil,
                        birthdayDate: responseData.birthdayDate,
                        gender: responseData.gender,
                        info: responseData.gender)
                    
                    DSSharedData.shared.userData = userData
                    let network = LoginRequestClass()
                    network.getTokenRequests { response in
                        switch response {
                        
                        case .success(let result):
                            switch result {
                            case .object(let responseData):
                                if let jwtToken = responseData.token {
                                    DSLoginData.shared.logIn(jwtToken: jwtToken)
                                }
                            case .emptyObject:
                                break
                            }
                        case .failure:
                            break
                        }
                    }
                case .failure:
                    break
                }
            }
        }

    }
    
    func doUploadSignUpDataToServer() {
        
    }
}
