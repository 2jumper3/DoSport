//
//  EventNetworkService.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/03/2021.
//

import Foundation

final class EventNetworkService {
    
    private let networkManager: NetworkManager = NetworkManagerImplementation.shared
    
    //MARK: - Events -
    
    /// Gets all events or events filtred by optional `queryComponents`
    ///
    /// - Parameters:
    ///     - queryComponents:
    ///     - completion:
    func eventsGet(
        queryComponents: DSModels.Event.EventByParametersRequest,
        completion: @escaping (DataHandler<[DSModels.Event.EventView]>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.getEvents(queryComponents)
        networkManager.makeRequest(
            endpoint: endpoint,
            bodyObject: DSEmptyRequest?.none,
            completion: completion
        )
    }
    
    /// Creates event and sends to the server
    ///
    /// - Parameters:
    ///     - body:
    ///     - completion:
    func eventCreate(
        body: DSModels.Event.EventRequest,
        completion: @escaping (DataHandler<DSModels.Event.EventView>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.createEvent
        networkManager.makeRequest(endpoint: endpoint, bodyObject: body, completion: completion)
    }
    
    /// Gets event from server by event id
    ///
    /// - Parameters:
    ///     - pathComponent:
    ///     - completion:
    func eventGetByID(
        pathComponent: DSModels.Event.EventByIDRequest,
        completion: @escaping (DataHandler<DSModels.Event.EventView>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.getEventByID(eventID: pathComponent.id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    /// Edits event in server by event id
    ///
    /// - Parameters:
    ///     - pathComponent:
    ///     - body:
    ///     - completion:
    func eventEditByID(
        pathComponent: DSModels.Event.EventByIDRequest,
        body: DSModels.Event.EventRequest,
        completion: @escaping (DataHandler<DSModels.Event.EventView>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.editEventByID(eventID: pathComponent.id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: body, completion: completion)
    }
    
    /// Deletes event from server by event id
    ///
    /// - Parameters:
    ///     - pathComponent:
    ///     - completion:
    func eventDeleteByID(
        pathComponent: DSModels.Event.EventByIDRequest,
        completion: @escaping (DataHandler<DSModels.Event.EventView>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.deleteEventByID(eventID: pathComponent.id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    //MARK: - Event Comments -
    
    /// Gets comments from event by event id
    ///
    /// - Parameters:
    ///     - pathComponent:
    ///     - completion:
    func eventGetCommentsByEventID(
        pathComponent: DSModels.Event.EventByIDRequest,
        completion: @escaping (DataHandler<[DSModels.Event.EventCommentView]>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.getEventComments(eventID: pathComponent.id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    /// Adds comment to some event by event id
    ///
    /// - Parameters:
    ///     - pathComponent:
    ///     - body:
    ///     - completion:
    func eventAddCommentByEventID(
        pathComponent: DSModels.Event.EventByIDRequest,
        body: DSModels.Event.EventCommentRequest,
        completion: @escaping (DataHandler<DSModels.Event.EventCommentView>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.addEventComment(eventID: pathComponent.id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: body, completion: completion)
    }
    
    /// Edits comment in event by event id and comment id
    ///
    /// - Parameters:
    ///     - pathComponent:
    ///     - body:
    ///     - completion:
    func eventEditCommentByID(
        pathComponent: DSModels.Event.EventAndCommentByIDRequest,
        body: DSModels.Event.EventCommentRequest,
        completion: @escaping (DataHandler<DSModels.Event.EventCommentEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.editEventComment(
            eventID: pathComponent.eventID,
            commentID: pathComponent.commentID
        )
        
        networkManager.makeRequest(endpoint: endpoint, bodyObject: body, completion: completion)
    }
    
    /// Deletes comment from event by event id and comment id
    ///
    /// - Parameters:
    ///     - pathComponent:
    ///     - completion:
    func eventDeleteCommentByEventID(
        pathComponent: DSModels.Event.EventAndCommentByIDRequest,
        completion: @escaping (DataHandler<DSModels.Event.EventCommentEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.deleteEventComment(
            eventID: pathComponent.eventID,
            commentID: pathComponent.commentID
        )
        
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    //MARK: - Event Members -
    
    /// Gets all users who participate in event by event id
    ///
    /// - Parameters:
    ///     - pathComponent:
    ///     - completion:
    func eventGetMembersByEventID(
        pathComponent: DSModels.Event.EventByIDRequest,
        completion: @escaping (DataHandler<[DSModels.User.UserView]>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.getMembersByEventID(eventID: pathComponent.id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    /// Adds current user as participant to event by event id
    ///
    /// - Parameters:
    ///     - pathComponent:
    ///     - completion:
    func eventAddMemberByEventID(
        pathComponent: DSModels.Event.EventByIDRequest,
        completion: @escaping (DataHandler<DSModels.Event.EventCommentEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.addMemberByEventID(eventID: pathComponent.id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    /// Deletes current user as participant from event by event id
    ///
    /// - Parameters:
    ///     - pathComponent:
    ///     - completion:
    func eventDeleteMemberByEventID(
        pathComponent: DSModels.Event.EventByIDRequest,
        completion: @escaping (DataHandler<DSModels.Event.EventCommentEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.deleteMemberByEventID(eventID: pathComponent.id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    /// Deletes some user as participant from event by his id and event id
    ///
    /// - Parameters:
    ///     - pathComponent:
    ///     - completion:
    func eventDeleleMemberByEventAndMemberID(
        pathComponent: DSModels.Event.EventAndCommentByIDRequest,
        completion: @escaping (DataHandler<DSModels.Event.EventCommentEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.deleteMemberByEventAndMemberID(
            eventID: pathComponent.eventID,
            userID: pathComponent.commentID
        )
        
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
}
 
