//
//  ErrorParser.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import Foundation

enum AppError: Error {
    case serverError
    case clientError
    case failData
    case unknownError
}

protocol AbstractErrorParser {

    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}

class ErrorParser: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return result
    }

    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}
