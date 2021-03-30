//
//  Endpoint.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

typealias QueryItems = [String: Any]

protocol Endpoint {
    var baseURL: URL { get }
    var fullURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var queryItems: QueryItems? { get }
    var headers: [String: Any] { get }
}

extension Endpoint {
    var baseURL: URL {
        return AppConfiguration.serverURL
    }
    
    var fullURL: URL {
        return baseURL.appendingPathComponent(path)
    }
    
    var headers: [String: Any] {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": String(describing: DSSharedData.shared.jwtToken ?? "")
        ]
    }
    
    var queryItems: QueryItems? {
        return [:]
    }
    
    var method: HTTPMethod {
        return .get
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
    case put = "PUT"
}
