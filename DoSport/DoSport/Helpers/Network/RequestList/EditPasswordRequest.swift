//
//  EditPasswordRequest.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import Foundation
import Alamofire

protocol EditPasswordRequestFactory {
    func editPassword(
        token: String,
        newPassword: String,
        newPasswordConfirm: String,
        oldPassword:String,
        completionHandler: @escaping (AFDataResponse<String>) -> Void
    )
}

class EditPasswordRequest: AbstractRequestFactory {
    
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

extension EditPasswordRequest: EditPasswordRequestFactory {
    func editPassword(
        token: String,
        newPassword: String,
        newPasswordConfirm: String,
        oldPassword:String,
        completionHandler: @escaping (AFDataResponse<String>) -> Void
    ) {
        let header = HTTPHeader(name: "Authorization", value: token)
        let headers = HTTPHeaders([header])
        
        let requestModel = EditPassword(
            headers: headers,
            baseUrl: baseUrl,
            newPassword: newPassword,
            newPasswordConfirm: newPasswordConfirm,
            oldPassword: oldPassword
        )
        
        self.request(request: requestModel, completionHandler: completionHandler)
        print("requestmodel printng \(requestModel)")
    }
}

extension EditPasswordRequest {
    struct EditPassword: RequestRouter {
        let headers: HTTPHeaders
        let baseUrl: URL
        let method: HTTPMethod = .patch
        let path: String = "profile/password"
        let newPassword: String
        let newPasswordConfirm: String
        let oldPassword: String
        var parameters: Parameters? {
            return [
                "newPassword": newPassword,
                "newPasswordConfirm": newPasswordConfirm,
                "oldPassword": oldPassword
            ]
        }
    }
}
