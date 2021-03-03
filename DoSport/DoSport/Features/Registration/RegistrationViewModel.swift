//
//  RegistrationViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import Foundation

final class RegistrationViewModel {
    
//    var onSuccess: (() -> Swift.Void)?
    
    init() {
        
    }
    
    func createUser(compilation: (() -> Void)) {
        print(#function)
        compilation()
    }
}

//MARK: Public API

extension RegistrationViewModel {
    
    func register(with viewData: RegistrationView.ViewData) {
        guard let params = checkRegisterData(for: viewData) else { return }
        
        ApiManager.requests.authRegister(params: params) { response in
            switch response.result {
            case .success(let responseData):
                print(responseData.username)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: Private API

private extension RegistrationViewModel {
    
    func checkRegisterData(for viewData: RegistrationView.ViewData) -> DSModels.Api.Auth.RegisterRequest? {
        guard let userName = viewData.userName, userName != "",
              let password = viewData.password, password != "",
              let passwordConfirm = viewData.passwordConfirm, passwordConfirm != "",
              let gender = viewData.gender, gender != "",
              let avatarImage = viewData.avatar?.toString()
        else {
            return nil // TODO: create some user response 
        }
        
        return DSModels.Api.Auth.RegisterRequest(
            email: "",
            username: userName,
            password: password,
            passwordConfirm: passwordConfirm,
            gender: gender,
            birthdayDate: viewData.dob,
            avatarImage: avatarImage
        )
    }
}
