//
//  SportTypeListViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

final class SportTypeListViewModel {
    
    var onDataDidPrepare: (([Sport]) -> Void)?
    
    private var sports: [Sport] = [] {
        didSet {
            onDataDidPrepare?(sports)
        }
    }
    
    private var selectedSports: [Sport] = []
    
    init() {
        
    }
    
    func prepareData() {
        self.sports = Sport.SportType.allCases.map { Sport(type: $0) }
    }
    
    func handleDataSelection(_ sport: Sport) {
        guard selectedSports.count > 0, !selectedSports.isEmpty else {
            selectedSports.append(sport)
            return
        }
        
        for (i, existedSport) in selectedSports.enumerated() {
            if existedSport == sport {
                selectedSports.remove(at: i)
            } else {
                selectedSports.append(sport)
            }
            return
        }
    }
    
    func saveData(compilation: () -> Void) {
        compilation()
    }
}
