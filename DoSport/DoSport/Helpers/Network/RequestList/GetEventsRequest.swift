//
//  GetEventsRequest.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/01/2021.
//

import Foundation
import Alamofire

protocol EventsRequestFactory {
    func getEvents(
        token: String,
        completionHandler: @escaping (AFDataResponse<Event>) -> Void
    )
}

final class GetEventsRequest: AbstractRequestFactory {
    
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue?
    
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

extension GetEventsRequest: EventsRequestFactory {
    func getEvents(
        token: String,
        completionHandler: @escaping (AFDataResponse<Event>) -> Void
    ) {
        let header = HTTPHeader(name: "Authorization", value: token)
        let headers = HTTPHeaders([header])
        let eventsEndpoint = EventsEndpoint(headers: headers)
        
        request(request: eventsEndpoint, completionHandler: completionHandler)
    }
}

extension GetEventsRequest {
    struct EventsEndpoint: RequestRouter {
        var baseUrl: URL = AppConfiguration.serverURL
        var method: HTTPMethod = .get
        var path: String = "events"
        var parameters: Parameters? = nil
        var headers: HTTPHeaders
    }
}



