//
//  NetworkManager.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

enum DataHandler<Success> where Success: Encodable & Decodable {
    case success(Success)
    case failure(NetworkErrorType)
}

protocol NetworkManager: class {
    func urlEncodingRequest<ResponseType: Codable>(
        endpoint: Endpoint,
        compilation: @escaping (DataHandler<ResponseType>) -> Void
    ) ->  URLSessionTask?
    
    func jsonEncodingRequest<ResponseType: Codable>(
        endpoint: Endpoint,
        compilation: @escaping (DataHandler<ResponseType>) -> Void
    ) ->  URLSessionTask?
}

final class NetworkManagerImplementation: NSObject, NetworkManager {
    
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
    
    fileprivate var encoder: JSONEncoder?
    private var dencoder = JSONDecoder()
    
    func urlEncodingRequest<ResponseType>(
        endpoint: Endpoint,
        compilation: @escaping (DataHandler<ResponseType>) -> Void
    ) -> URLSessionTask? where ResponseType: Codable {
        
        guard let resultURL = self.buildResultURL(using: endpoint) else {
            return nil
        }
        
        return self.session.dataTask(with: resultURL) { data, response, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                compilation(.failure(.clientError))
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                debugPrint(httpResponse.statusCode)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let result: ResponseType = try self.dencoder.decode(ResponseType.self, from: data)
                OperationQueue.main.addOperation {
                    compilation(.success(result))
                }
            } catch let error {
                debugPrint(error.localizedDescription)
                compilation(.failure(.decodingError))
            }
        }
    }
    
    func jsonEncodingRequest<ResponseType>(
        endpoint: Endpoint,
        compilation: @escaping (DataHandler<ResponseType>) -> Void
    ) ->  URLSessionTask? where ResponseType: Codable {
        
        guard let resultRequest = self.buildRequstFromURL(using: endpoint) else {
            return nil
        }
        
        return self.session.dataTask(with: resultRequest) { data, response, error in
            if let error = error {
                debugPrint(error.localizedDescription, #file, #line)
                compilation(.failure(.clientError))
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                debugPrint(httpResponse.statusCode, #file, #line)
                return
            }
            
            guard let data = data, !data.isEmpty else { return }
            
            do {
                let result: ResponseType = try JSONDecoder().decode(ResponseType.self, from: data)
                compilation(.success(result))
            } catch let error {
                debugPrint(error.localizedDescription, #file, #line)
                compilation(.failure(.decodingError))
            }
        }
    }
}

//MARK: - URLSessionDelegate -

extension NetworkManagerImplementation: URLSessionDelegate {
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        debugPrint(#function)
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        debugPrint(#function, error?.localizedDescription ?? "", #file, #line)
    }
}

//MARK: Private API

private extension NetworkManagerImplementation {
    
    func buildResultURL(using endpoint: Endpoint) -> URL? {
        let url = endpoint.fullURL
        
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
    
    func buildRequstFromURL(using endpoint: Endpoint) -> URLRequest? {
        let url = endpoint.fullURL
        
        let queryItems = endpoint.parameters?.compactMap { (name, value) -> URLQueryItem? in
            return URLQueryItem(name: name, value: value as? String)
        }
        
        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.queryItems = queryItems
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        endpoint.headers.forEach { (key, value) in
            if let value = value as? String {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        guard let query = urlComponents?.url?.query else {
            return nil
        }
        
        request.httpBody = Data(query.utf8)
        
        return request
    }
}
