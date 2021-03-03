//
//  UserMainViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import Foundation

final class UserMainViewModel {
    
    var onDidPrepareEventsData: (([Event]) -> Void)?
    
    var events: [Event]? {
        didSet {
            guard let events = events else { return }
            onDidPrepareEventsData?(events)
        }
    }
    
    init() {
        
    }
}

//MARK: - Public methods

extension UserMainViewModel {
    
    func prepareEventData() {
        
    }
}
