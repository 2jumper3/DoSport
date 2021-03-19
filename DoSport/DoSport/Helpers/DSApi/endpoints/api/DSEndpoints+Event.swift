//
//  DSEndpoints+Event.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSEndpoints {
    enum Event {
        
        struct GetEvents: Endpoint {
            var method: HTTPMethod = .get
            var path: String = "events"
            var parameters: Parameters?
        }
    }
}
