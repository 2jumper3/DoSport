//
//  NetworkErrorType.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 19/03/2021.
//

import Foundation

enum NetworkErrorResponseType: Error {
    case serverError
    case clientError
    case failData
    case encodingError
    case decodingError
    case unknownError
}
