//
//  Endpoint.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

typealias Parameters = [String: Any]

enum ParameterEncoding {
    case urlEndoding, jsonEncoding
}

protocol Endpoint {
    var baseURL: URL { get }
    var fullURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var headers: [String: Any] { get }
    var parameterEncoding: ParameterEncoding { get }
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
            "Accept": "application/json"
        ]
    }
    
    var parameters: Parameters? {
        return [:]
    }
    
    var parameterEncoding: ParameterEncoding {
        return .urlEndoding
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