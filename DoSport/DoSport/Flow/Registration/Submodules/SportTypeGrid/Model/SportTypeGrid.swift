//
//  SportTypeGrid.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/03/2021.
//

import Foundation

/// This class describes `SportTypeGrid` screen's basic use cases and model.
final class SportTypeGrid {
    
    struct SportType: Identifiable {
        let name: String
        var isSelected: Bool
        let id: Int
    }
    
    var sportTypes: Array<SportTypeGrid.SportType> = .init()
    var selectedSportTypes: Array<SportTypeGrid.SportType> = .init()
    
    func selectSportType(_ sportType: SportTypeGrid.SportType) {
        guard let selectedIndex = self.index(of: sportType) else { return }
        
        if self.selectedSportTypes.isEmpty {
            self.selectedSportTypes.append(sportType)
        } else {
            if let existedIndex = self.getIndexIfAlreadyExists(sportType) {
                self.selectedSportTypes.remove(at: existedIndex)
            } else {
                self.selectedSportTypes.append(sportType)
            }
        }
        
        self.sportTypes[selectedIndex].isSelected = !self.sportTypes[selectedIndex].isSelected
    }
    
    private func getIndexIfAlreadyExists(_ sportType: SportTypeGrid.SportType) -> Int? {
        for index in self.selectedSportTypes.indices {
            if self.selectedSportTypes[index].id == sportType.id {
                return index
            }
        }
        
        return nil
    }
    
    private func index(of sportType: SportTypeGrid.SportType) -> Int? {
        for index in self.sportTypes.indices {
            if self.sportTypes[index].id == sportType.id {
                return index
            }
        }
        
        return nil
    }
}

