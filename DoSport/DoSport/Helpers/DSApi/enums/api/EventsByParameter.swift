//
//  EventsByParameter.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 20/03/2021.
//

import Foundation

extension DSEnums {
    
    enum EventsByParameter {
        case fromDate(Date)
        case organiserID(Int)
        case sportGroundID(Int)
        case sportTypeID(Int)
        case toDate(Int)
        
        static func getParams(_ params: EventsByParameter...) -> [EventsByParameter] {
            return params
        }
    }
}
