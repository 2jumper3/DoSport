//
//  NetworkErrorType.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 19/03/2021.
//

import Foundation

enum NetworkErrorType: Error {
    case serverError
    case clientError
    case failData
    case unknownError
}
