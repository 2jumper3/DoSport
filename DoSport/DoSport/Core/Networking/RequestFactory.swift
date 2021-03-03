//
//  RequestFactory.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import Foundation
import Alamofire

final class RequestFactory: AbstractRequestFactory {
    
    var errorParser: AbstractErrorParser = ErrorParser()
    var queue: DispatchQueue? = DispatchQueue.global(qos: .utility)
    let baseUrl = URL(string: "https://dosport-ru.herokuapp.com/api/v1/")!
    
    var sessionManager: Session  = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        
        let manager = Session(configuration: configuration)
        
        return manager
    }()
}

