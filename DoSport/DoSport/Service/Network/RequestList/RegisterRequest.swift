//
//  RegisterRequest.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//
import Foundation
import Alamofire

protocol RegisterRequestFactory {
    func register(
        firstname: String,
        lastname: String,
        password: String,
        passwordConfirm: String,
        username: String,
        completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void
    )
}

class RegisterRequest: AbstractRequestFactory {
    
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue?
    let baseUrl = URL(string: "https://dosport-ru.herokuapp.com/api/v1/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue? = DispatchQueue.global(qos: .utility)
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

// MARK: - забиваем даные

extension RegisterRequest: RegisterRequestFactory {
    //в @escaping вставляем модель из responses в каком формате оно выйдет легко проверить через приложение insomnia
    func register(
        firstname: String,
        lastname: String,
        password: String,
        passwordConfirm: String,
        username: String,
        completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void
    ) {
        let requestModel = Register(
            headers: HTTPHeaders([]),
            baseUrl: baseUrl,
            firstname: firstname,
            lastname: lastname,
            password: password,
            passwordConfirm: passwordConfirm,
            username: username
        )
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension RegisterRequest {
    struct Register: RequestRouter {
        var headers: HTTPHeaders
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "profile" //адрес послеbaseUrl
        //все переменные которые уходят на сервер
        let firstname: String
        let lastname: String
        let password: String
        let passwordConfirm: String
        let username: String
        var parameters: Parameters? {
            return [
                "firstName": firstname,
                "lastName": lastname,
                "password": password,
                "passwordConfirm": password,
                "username": username
            ]
        }
    }
}
