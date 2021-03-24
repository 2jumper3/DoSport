//
//  LoginAPI.swift
//  DoSport
//
//  Created by Sergey on 12.03.2021.
//

import Foundation

class VKSession {
    
    static let shared = VKSession()
    
    private init () {}
    
    //MARK: - изменить client_id на id приложения вк
    
    let client_id = "6895964"
    var userName: String?
    var tokenID: String?
    var email: String?
}
