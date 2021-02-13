//
//  SportTypeListViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import Foundation

final class SportTypeListViewModel {
    
    var onDidPrepareData: (([Sport]) -> Void)?
    
    private var sports: [Sport]? {
        didSet {
            guard let sports = sports else { return }
            
            onDidPrepareData?(sports)
        }
    }
    
    init() {
        
    }
}

//MARK: - Public methods

extension SportTypeListViewModel {
    
    func prepareData() {
        sports = Sport.SportType.allCases.map { Sport(type: $0) }
    }
}
