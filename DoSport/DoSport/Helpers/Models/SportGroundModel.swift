//
//  SportGround.swift
//  DoSport
//
//  Created by MAC on 23.01.2021.
//

import UIKit

// Тестовая модель, все поменяется когда будет известен json
enum MetroLine: String, CaseIterable {
    case green
    case red

    var icon: UIImage? {
        switch self {
        case .green:
            return #imageLiteral(resourceName: "greenline").withRenderingMode(.alwaysOriginal)
        case .red:
            return #imageLiteral(resourceName: "redline").withRenderingMode(.alwaysOriginal)
        }
    }
}


struct SportGroundModel {

    let sportGroundName: String
    let metroName: String
    let metroLine: MetroLine
    let directionToPlace: Int
    let price: String
    let backgroundImageString: String

    static func returnSportGroundModelsList() -> [SportGroundModel] {
        let typeOfSportGrounds = [
            SportGroundModel(sportGroundName: "Трехгорка", metroName: "Краснопресенская", metroLine: .green, directionToPlace: 3, price: "Бесплатно", backgroundImageString: ""),
            SportGroundModel(sportGroundName: "White House", metroName: "Краснопресенская", metroLine: .red, directionToPlace: 4, price: "Бесплатно", backgroundImageString: ""),
            SportGroundModel(sportGroundName: "BES", metroName: "Улица 1905 года", metroLine: .green, directionToPlace: 5, price: "Бесплатно", backgroundImageString: ""),
            SportGroundModel(sportGroundName: "Шмитовский", metroName: "Улица 1905 года", metroLine: .red, directionToPlace: 7, price: "Бесплатно", backgroundImageString: ""),
            SportGroundModel(sportGroundName: "Школа 1950", metroName: "Маяковская", metroLine: .red, directionToPlace: 8, price: "Бесплатно", backgroundImageString: ""),
            SportGroundModel(sportGroundName: "Трехгорка", metroName: "Краснопресенская", metroLine: .green, directionToPlace: 3, price: "Бесплатно", backgroundImageString: ""),
            SportGroundModel(sportGroundName: "White House", metroName: "Краснопресенская", metroLine: .red, directionToPlace: 4, price: "Бесплатно", backgroundImageString: ""),
            SportGroundModel(sportGroundName: "BES", metroName: "Улица 1905 года", metroLine: .green, directionToPlace: 5, price: "Бесплатно", backgroundImageString: ""),
            SportGroundModel(sportGroundName: "Шмитовский", metroName: "Улица 1905 года", metroLine: .red, directionToPlace: 7, price: "Бесплатно", backgroundImageString: ""),
            SportGroundModel(sportGroundName: "Школа 1950", metroName: "Маяковская", metroLine: .red, directionToPlace: 8, price: "Бесплатно", backgroundImageString: "")
        ]

        return typeOfSportGrounds
    }
}
