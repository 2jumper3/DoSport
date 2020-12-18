//
//  AuthRequest.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
}

class AuthRequest: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue?
    let baseUrl = URL(string: "https://dosport-ru.herokuapp.com/api/v1/")!
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension AuthRequest: AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(headers: HTTPHeaders([]), baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)

    }
}

extension AuthRequest {
    struct Login: RequestRouter {
        var headers: HTTPHeaders
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "auth/login"
        let login: String
        let password: String

        var parameters: Parameters? {
            return [
                "email": login,
                "password": password
            ]
        }
    }
}
