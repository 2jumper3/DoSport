//
//  SignUpModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/03/2021.
//

import Foundation

final class SignUpModel {
    
    enum SaveButtonState {
        case disabled
        case enabled
    }
    
    var createButtonState: SignUpModel.SaveButtonState = .disabled
    
    func changeCreateButtonState(_ state: SignUpModel.SaveButtonState) {
        self.createButtonState = state
    }
    
    struct User {
        let userPhoto: Data
        let userName: String
        let dateOfBirth: String
        let gender: String
    }
}
