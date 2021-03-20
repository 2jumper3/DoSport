//
//  EventRequests.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension RequestsManager {
    
    //MARK: - Events -
    
    func eventsGet(
        completion: @escaping (DataHandler<[DSModels.Event.GetEventsResponse]>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.getEvents
        request(endpoint: endpoint, compilation: completion)
    }
    
    func eventCreate(
        params: DSModels.Event.CreateEventRequest,
        completion: @escaping (DataHandler<DSModels.Event.GetEventsResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.createEvent(params)
        request(endpoint: endpoint, compilation: completion)
    }
    
    func eventGetByParameters(
        params: DSModels.Event.GetEventsByParameters,
        completion: @escaping (DataHandler<[DSModels.Event.GetEventsResponse]>) -> Void
    ) {
        let endpoints = DSEndpoints.Event.getEventsByParams(params)
        request(endpoint: endpoints, compilation: completion)
    }
    
    func eventsGetIfCreatedByCurrentUser(
        completion: @escaping (DataHandler<[DSModels.Event.GetEventsResponse]>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.getEventsOfCurrentUser
        request(endpoint: endpoint, compilation: completion)
    }
    
    func eventEditBy(
        eventID id: Int,
        params: DSModels.Event.EditEventRequest,
        completion: @escaping (DataHandler<DSModels.Event.GetEventsResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.editEvent(eventID: id, params)
        request(endpoint: endpoint, compilation: completion)
    }
    
    func eventDeleteBy(
        params: DSModels.Event.DeleteEventRequest,
        completion: @escaping (DataHandler<DSModels.Event.DeleteEventResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.deleteEvent(eventID: params.id)
        request(endpoint: endpoint, compilation: completion)
    }
    
    //MARK: - Event Members -
    
    func eventGetMembers() {
        
    }
    
    func eventAddMember() {
        
    }
    
    func eventGetMemberBy() {
        
    }
    
    func eventDeleteMemberBy() {
        
    }
    
    func eventsGetIfCurrentUserIsMember() {
        
    }
    
    //MARK: - Event Comments -
    
    func eventGetComments() {
        
    }
    
    func eventAddComment() {
        
    }
    
    func eventEditCommentBy() {
        
    }
    
    func eventDeleteCommentBy() {
        
    }
}
