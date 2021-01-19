//
//  SportTypeModel.swift
//  DoSport
//
//  Created by MAC on 17.01.2021.
//

import Foundation

struct SportTypeModel {

    let titleType: String
    let iconType: String

    static func returnSportTypeModelsList() -> [SportTypeModel] {
        let typeOfSports = [
            SportTypeModel(titleType: SportType.football.description, iconType: SportType.football.rawValue),
            SportTypeModel(titleType: SportType.basketball.description, iconType: SportType.basketball.rawValue),
            SportTypeModel(titleType: SportType.hockey.description, iconType: SportType.hockey.rawValue),
            SportTypeModel(titleType: SportType.volleyball.description, iconType: SportType.volleyball.rawValue),
            SportTypeModel(titleType: SportType.tennis.description, iconType: SportType.tennis.rawValue),
            SportTypeModel(titleType: SportType.workout.description, iconType: SportType.workout.rawValue),
            SportTypeModel(titleType: SportType.run.description, iconType: SportType.run.rawValue),
            SportTypeModel(titleType: SportType.gym.description, iconType: SportType.gym.rawValue),
            SportTypeModel(titleType: SportType.yoga.description, iconType: SportType.yoga.rawValue),
            SportTypeModel(titleType: SportType.box.description, iconType: SportType.box.rawValue),
            SportTypeModel(titleType: SportType.group.description, iconType: SportType.group.rawValue),
            SportTypeModel(titleType: SportType.dance.description, iconType: SportType.dance.rawValue),
            SportTypeModel(titleType: SportType.tabletennis.description, iconType: SportType.tabletennis.rawValue),
            SportTypeModel(titleType: SportType.skateboard.description, iconType: SportType.skateboard.rawValue),
            SportTypeModel(titleType: SportType.badminton.description, iconType: SportType.badminton.rawValue)
        ]

        return typeOfSports
    }
}


