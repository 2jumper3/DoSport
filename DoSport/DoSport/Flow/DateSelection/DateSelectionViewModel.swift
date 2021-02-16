//
//  DateSelectionViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import Foundation

final class DateSelectionViewModel {
    
    var onDidPrepareData: (([String]) -> Void)?
    
    private var hours: [String] = [] {
        didSet {
            onDidPrepareData?(hours)
        }
    }
    
    init() {
        
    }
}

//MARK: - Public methods

extension DateSelectionViewModel {
    
    func prepareData() {
        self.hours = Event.Hour.allCases.map { $0.rawValue }
    }
}
