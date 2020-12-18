//
//  Responses.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//
import Foundation

//Structs for parsing

// MARK: - LoginResult
struct LoginResult: Codable {
    let token: String
    enum CodingKeys: String, CodingKey {
        case token
    }
}

// MARK: - RegisterResult
struct RegisterResult: Codable {
    let idResult: Int
    let username: String
}
// MARK: - UserInfoResult
struct UserInfoResult: Codable {
    let birthdayDate: String?
    let firstName, gender: String
    let hideBirthdayDate: Bool
    let id: Int
    let info, photoLink: String?
    let lastName,username: String
    
    enum CodingKeys: String, CodingKey {
        case birthdayDate = "birthdayDate"
        case firstName = "firstName"
        case gender = "gender"
        case hideBirthdayDate = "hideBirthdayDate"
        case id = "id"
        case info = "info"
        case lastName = "lastName"
        case photoLink = "photoLink"
        case username = "username"
    }
}
