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
        completion: @escaping (DataHandler<DSModels.Event.GetEventsResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.Event.GetEvents()
        request(endpoint: endpoint, compilation: completion)
    }
    
    func eventGetBy() {
        
    }
    
    func eventsGetBy() {
        
    }
    
    func eventsGetIfCreatedByCurrentUser() {
        
    }
    
    func eventCreate() {
        
    }
    
    func eventEditBy() {
        
    }
    
    func eventDeleteBy() {
        
    }
    
    //MARK: - Event Members -
    
    func eventGetMembersBy() {
        
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
