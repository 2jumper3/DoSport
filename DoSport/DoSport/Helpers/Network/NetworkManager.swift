//
//  NetworkManager.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

enum DataHandler<ResponseType> where ResponseType: Encodable & Decodable {
    case success(NetworkSuccessResponseType<ResponseType>)
    case failure(NetworkErrorResponseType)
}

protocol NetworkManager: class {
    func makeRequest<RequestBody, ResponseType>(
        endpoint: Endpoint,
        bodyObject: RequestBody?,
        compilation: @escaping (DataHandler<ResponseType>) -> Void
    ) ->  URLSessionTask? where RequestBody: Codable, ResponseType: Codable
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
    
    fileprivate var encoder = JSONEncoder()
    private var dencoder = JSONDecoder()
    
    func makeRequest<RequestBody, ResponseType>(
        endpoint: Endpoint,
        bodyObject: RequestBody?,
        compilation: @escaping (DataHandler<ResponseType>) -> Void
    ) ->  URLSessionTask? where RequestBody: Codable, ResponseType: Codable {
        
        guard let resultRequest = self.buildRequest(using: endpoint, bodyObject: bodyObject) else {
            return nil
        }
        
        return self.session.dataTask(with: resultRequest) { data, response, error in
            if let error = error {
                debugPrint(error.localizedDescription, #file, #line)
                compilation(.failure(.clientError))
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                debugPrint("## - Status code: \(httpResponse.statusCode)", #line)
                compilation(.failure(.serverError))
                return
            }
            
            guard let data = data, !data.isEmpty else { return }
            
            do {
                let result: ResponseType = try JSONDecoder().decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    compilation(.success(.object(result)))
                }
            } catch let error {
                debugPrint(error.localizedDescription, #file, #line)
                compilation(.failure(.decodingError))
            }
        }
    }
}

//MARK: - URLSessionDelegate -

extension NetworkManagerImplementation: URLSessionDelegate { }

//MARK: Private API

private extension NetworkManagerImplementation {
    
    func buildRequest<T>(
        using endpoint: Endpoint,
        bodyObject: T? = nil
    ) -> URLRequest? where T: Codable {
        let url = endpoint.fullURL
        var request: URLRequest?
        
        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.queryItems = self.setupQueryItems(endpoint.queryItems)
        
        guard let resultURL = urlComponents?.url else { return nil }
        
        request = URLRequest(url: resultURL)
        request?.httpMethod = endpoint.method.rawValue
        
        endpoint.headers.forEach { (key, value) in
            if let value = value as? String {
                request?.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if endpoint.method != .get {
            do {
                let httpBody = try JSONEncoder().encode(bodyObject)
                
                if let jsonString = String(data: httpBody, encoding: .utf8) {
                    print(jsonString)
                }
                
                request?.httpBody = httpBody
            } catch let err {
                debugPrint(err.localizedDescription)
            }
        }
        
        return request
    }
    
    func setupQueryItems(_ items: [String: Any]?) -> [URLQueryItem]? {
        return items?.compactMap { (name, value) -> URLQueryItem? in
            return URLQueryItem(name: name, value: value as? String)
        }
    }
}
