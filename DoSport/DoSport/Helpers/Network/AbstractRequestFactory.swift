//
//  AbstractRequestFactory.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//


import Foundation
import Alamofire

protocol AbstractRequestFactory {
    var errorParser: AbstractErrorParser { get }
    var sessionManager: Session { get }
    var queue: DispatchQueue? { get }
    
    @discardableResult
    func request<T: Decodable>(
        request: URLRequestConvertible,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) -> DataRequest
}

extension AbstractRequestFactory {
    
    @discardableResult
    public func request<T: Decodable>(
        request: URLRequestConvertible,
        completionHandler: @escaping (AFDataResponse<T>) -> Void
    ) -> DataRequest {
        return sessionManager
            .request(request)
            .responseDecodable(completionHandler: completionHandler)
            .validate()
    }
}
