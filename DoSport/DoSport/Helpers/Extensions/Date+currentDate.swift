//
//  Date+currentDate.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/02/2021.
//

import Foundation

extension Date {
    
    public var removeTimeStamp : Date? {
        guard
            let date = Calendar.current.date(
                from: Calendar.current.dateComponents(
                    [.year, .month, .day],
                    from: self
                )
            )
        else {
            return nil
        }
        
        return date
    }
}
