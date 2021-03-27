//
//  Calendar+currnetComponent.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 16/03/2021.
//

import Foundation

extension Calendar {
    
    static func current(_ component: Component, for date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(component, from: date)
    }
}
