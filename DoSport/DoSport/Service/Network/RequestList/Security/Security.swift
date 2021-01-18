//
//  Security.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import Foundation

//MARK:- Временное решение

final class Token {
    
    func saveToken(token: String) {
        UserDefaults.standard.setValue("Bearer_" + token + "", forKey: "token")
    }
    
    func loadToken() -> String {
        if let token = UserDefaults.standard.object(forKey: "token") as? String {
            return token
        } else {
            return ""
        }
    }
}
