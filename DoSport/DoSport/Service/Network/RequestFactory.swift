//
//  RequestFactory.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import Foundation
import Alamofire

class RequestFactory {
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        
        let manager = Session(configuration: configuration)
        
        return manager
    }()
    
    // MARK: - тут выносишь по данному принципу все реквесты, которые потом легко доступны через класс
    
    func makeAuthRequest() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        
        return AuthRequest(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue
        )
    }
    
    func makeRegisterRequest() -> RegisterRequestFactory {
        let errorParser = makeErrorParser()
        
        return RegisterRequest(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue
        )
    }
    
    func makeUserInfoRequest() -> UserInfoRequestFactory {
        let errorParser = makeErrorParser()
        
        return GetInfoRequest(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue
        )
    }
    
    func makeEditPasswordRequest() -> EditPasswordRequestFactory {
        let errorParser = makeErrorParser()
        
        return EditPasswordRequest(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue
        )
    }
    
    func makeGetEventsRequest() -> EventsRequestFactory {
        let errorParser = makeErrorParser()
        
        return GetEventsRequest(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue
        )
    }
}
