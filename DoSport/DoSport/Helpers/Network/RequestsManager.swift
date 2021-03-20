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
    
    func request<ResponseType: Codable>(
        endpoint: Endpoint,
        compilation: @escaping (DataHandler<ResponseType>) -> Void
    ) {
        
        let task: URLSessionTask?
        
        switch endpoint.parameterEncoding{
        case .jsonEncoding:
            task = httpNetworkManager.jsonEncodingRequest(
                endpoint: endpoint,
                compilation: compilation
            )
        case .urlEncoding:
            task = httpNetworkManager.urlEncodingRequest(
                endpoint: endpoint,
                compilation: compilation
            )
        }
        
        task?.resume()
    }
}
