//
//  SportGroundViewModel.swift
//  DoSport
//
//  Created by MAC on 23.01.2021.
//

import Foundation

protocol SportGroundViewModelProtocol: class {
    func returnCountOfSportsGround() -> Int
    func configureCell(indexPath: IndexPath) -> SportGroundModel
}

final class SportGroundViewModel: SportGroundViewModelProtocol  {

    // MARK: - Properties
    private var countSportsGround: [SportGroundModel] = []

    // MARK: - Lifecycle
    init() {
        fetchCountTypeOfSport()
    }

    // MARK: - Helpers functions
    private func fetchCountTypeOfSport() {
        let sportGrounds = SportGroundModel.returnSportGroundModelsList()
        self.countSportsGround = sportGrounds
    }

    func returnCountOfSportsGround() -> Int {
        return countSportsGround.count
    }

    func configureCell(indexPath: IndexPath) -> SportGroundModel {
        return countSportsGround[indexPath.item]
    }
}
