//
//  NetworkManager.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

protocol NetworkManager: class {
    func request<ResponseType: Codable>(
        endpoint: Endpoint,
        compilation: @escaping (Result<ResponseType, NetworkErrorType>) -> Swift.Void
    )
}

class NetworkManagerImplementation: NSObject, NetworkManager {
    
    private let queue: OperationQueue = {
        $0.qualityOfService = .background
        $0.maxConcurrentOperationCount = 1
        return $0
    }(OperationQueue())
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.httpShouldSetCookies = false
        
        return URLSession(
            configuration: configuration,
            delegate: self,
            delegateQueue: self.queue
        )
    }()
    
    //MARK: Request
    
    func request<ResponseType>(
        endpoint: Endpoint,
        compilation: @escaping (Result<ResponseType, NetworkErrorType>) -> Void
    ) where ResponseType: Codable {
        
        if let resultURL = self.buildResultURL(using: endpoint) {
            let task: URLSessionTask? = self.session.dataTask(with: resultURL) { data, response, error in
                if let error = error {
                    debugPrint(error.localizedDescription)
                    compilation(.failure(.clientError))
                }
                
                guard
                    let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode)
                else {
                    debugPrint(error?.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    compilation(.failure(.failData))
                    return
                }
                
                do {
                    let result: ResponseType = try JSONDecoder().decode(ResponseType.self, from: data)
                    compilation(.success(result))
                } catch let error {
                    debugPrint(error.localizedDescription)
                    compilation(.failure(.unknownError))
                }
            }
            
            task?.resume()
        }
    }
}

//MARK: - URLSessionDelegate -

extension NetworkManagerImplementation: URLSessionDelegate {
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        debugPrint(#function)
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        debugPrint(#function, error?.localizedDescription ?? "")
    }
}

//MARK: Private API

private extension NetworkManagerImplementation {
    
    func buildResultURL(using endpoint: Endpoint) -> URL? {
        let url = endpoint.baseURL
        
        let queryItems = endpoint.parameters?.compactMap { (name, value) -> URLQueryItem? in
            return URLQueryItem(name: name, value: value as? String)
        }
        
        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.queryItems = queryItems
        
        guard let resultURL = urlComponents?.url else {
            return nil
        }
        
        return resultURL
    }
}
