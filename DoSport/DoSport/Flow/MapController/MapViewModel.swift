//
//  MapViewModel.swift
//  DoSport
//
//  Created by Sergey on 28.12.2020.
//

import Foundation
import CoreLocation

final class MapViewModel {
    var coordinates: [Coordinate]? {
        didSet {
//            self.coordinates = loadCoordinates()
        }
    }
    
    func loadCoordinates() {
        let first = Coordinate(latitude: 55.847695, longitude: 37.361076, id: 1, name: "First", range: 22, price: 10000, location: "Peter")
        let second = Coordinate(latitude: 55.849125, longitude: 37.361724, id: 2, name: "Second", range: 22, price: 10000, location: "Moscow")
        let third = Coordinate(latitude: 55.850682, longitude: 37.357555, id: 3, name: "Third", range: 22, price: 10000, location: "Novosib")
        self.coordinates = [first,second,third]
    }
    
    func placemarkTapped() {
        
    }
}
