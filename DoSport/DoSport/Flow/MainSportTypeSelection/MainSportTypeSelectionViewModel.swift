//
//  MainSportTypeSelectionViewModel.swift
//  DoSport
//
//  Created by MAC on 03.03.2021.
//

import Foundation

final class MainSportTypeSelectionViewModel {
    
    var onMainSportTypeModelsReady: (([Sport]) -> Swift.Void)?
    
    private var sportTypeModels: [Sport] = [] {
        didSet {
            onMainSportTypeModelsReady?(sportTypeModels)
        }
    }
    
    private var filteredSportTypeModels: [Sport] = [] {
        didSet {
            onMainSportTypeModelsReady?(filteredSportTypeModels)
        }
    }
    
    private var searchText: String = ""

    //MARK: Init
    
    init() { }
}

//MARK: Public API

extension MainSportTypeSelectionViewModel {
    
    func prepareSportTypeModels() {
        sportTypeModels = Sport.SportType.allCases.map { Sport(type: $0) }
    }
    
    func searchSportType(by text: String, string: String) {
        searchText = text + string
        
        if string  == "" {
            let range = searchText.startIndex..<searchText.index(before: searchText.endIndex)
            searchText = String(searchText[range])
        }
        
        if searchText == "" {
            onMainSportTypeModelsReady?(sportTypeModels)
        } else {
            getSearchArrayContains(searchText)
        }
    }
}

//MARK: Private API

private extension MainSportTypeSelectionViewModel {
    
    private func getSearchArrayContains(_ text : String) {
        filteredSportTypeModels = sportTypeModels.filter { sportType -> Bool in
            guard let title = sportType.title else {
                return false
            }
            
            return title.lowercased().contains(text.lowercased())
        }
    }
}
