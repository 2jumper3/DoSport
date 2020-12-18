//
//  EditUserInfo.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import Foundation
import Alamofire

protocol EditInfoRequestFactory {
    func editInfo(token: String, completionHandler: @escaping (AFDataResponse<UserInfoResult>) -> Void)
}

class EditInfoRequest: AbstractRequestFactory {
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

extension EditInfoRequest: EditInfoRequestFactory {
    func editInfo(token: String, completionHandler: @escaping (AFDataResponse<UserInfoResult>) -> Void) {
        let header = HTTPHeader(name: "Authorization", value: token)
        let headers = HTTPHeaders([header])
        let requestModel = EditInfo(headers: headers, baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
        print("requestmodel printng \(requestModel)")
    }
}

extension EditInfoRequest {
    struct EditInfo: RequestRouter {
        var headers: HTTPHeaders
        let baseUrl: URL
        let method: HTTPMethod = .patch
        let path: String = "profile"
        var parameters: Parameters?
    }
}
