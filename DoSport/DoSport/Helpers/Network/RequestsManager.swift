//
//  RequestsManager.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import Foundation

final class RequestsManager {
    
    static let shared = RequestsManager()
    
    let httpNetworkManager: NetworkManager = NetworkManagerImplementation()
}
