//
//  AuthViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import Foundation

final class AuthViewModel {
    
    /// TEMPRORARY ENUM.
    ///
    /// For TEST purposes.
    ///
    /// REMOVE when back-end is ready
    
    enum AuthResult {
        case registred, notRegistred
    }
    
    init() {
        
    }
    
    func checkIfNumberExists(compilation: (AuthResult) -> Void) {
        // TODO: some networking logic when back-end is ready
        compilation(.notRegistred)
    }
}
