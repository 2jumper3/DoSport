//
//  DSEndpoints+Auth.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSEndpoints {
    enum Auth: Endpoint {
        case signIn // temprorary. will be replaced by socialMedia auth
        case signUp // temprorary. will be replaced by socialMedia auth
        
        var path: String {
            switch self {
            case .signIn: return "auth/login"
            case .signUp: return "auth/register"
            }
        }
        
        var method: HTTPMethod {
            return .post
        }
    }
}
