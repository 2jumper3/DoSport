//
//  SportGroundSelectionListViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import Foundation

final class SportGroundSelectionListViewModel {
    
    var onDidPrepareData: (([SportGround]) -> Void)?
    
    private var sportGrounds: [SportGround]? {
        didSet {
            guard let sportGrounds = sportGrounds else { return }
            
            onDidPrepareData?(sportGrounds)
        }
    }
    
    init() {
        
    }
}

//MARK: - Public methods

extension SportGroundSelectionListViewModel {
    
    func prepareData() {
        var tempSportGrounds: [SportGround] = []
        
        for i in 0..<19 {
            let sportGround = SportGround(
                sportGroudID: i,
                title: "SportGround title \(i)",
                address: "Address \(i)",
                city: "City \(i)",
                events: [],
                lattitude: 0.0,
                longitude: 0.0,
                sportTypes: []
            )
            tempSportGrounds.append(sportGround)
        }
        self.sportGrounds = tempSportGrounds
    }
}
