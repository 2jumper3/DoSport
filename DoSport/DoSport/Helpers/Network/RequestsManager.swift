//
//  RequestsManager.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import Foundation

struct DSEmptyRequest: Codable { }

final class RequestsManager {
    
    static let shared = RequestsManager()
    
    let httpNetworkManager: NetworkManager = NetworkManagerImplementation()
    
    func request<RequestBody, ResponseType>(
        endpoint: Endpoint,
        bodyObject: RequestBody? = nil,
                completion: @escaping (DataHandler<ResponseType>) -> Void
    ) where RequestBody: Codable, ResponseType: Codable {
        
        let task: URLSessionTask? = httpNetworkManager.makeRequest(
            endpoint: endpoint,
            bodyObject: bodyObject,
            compilation: completion
        )
        
        task?.resume()
    }
}
