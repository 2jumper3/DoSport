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
            
        }
    }
    
    func loadCoordinates() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 59.945933, longitude: 30.320045)
    }
}
