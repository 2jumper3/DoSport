//
//  MapViewModel.swift
//  DoSport
//
//  Created by Sergey on 28.12.2020.
//

import Foundation
import CoreLocation

final class MapViewModel {
    var coordinates: [MapModel]? {
        didSet {
//            self.coordinates = loadCoordinates()
        }
    }
    
    func loadCoordinates() {
        let first = MapModel(latitude: 55.847695, longitude: 37.361076)
        let second = MapModel(latitude: 55.849125, longitude: 37.361724)
        let third = MapModel(latitude: 55.850682, longitude: 37.357555)
        self.coordinates = [first,second,third]
    }
    
    func placemarkTapped() {
        
    }
}
