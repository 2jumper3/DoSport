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
