//
//  NetworkSuccessResponseType.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 21/03/2021.
//

import Foundation

enum NetworkSuccessResponseType {
    case object(Codable)
    case emptyObject
    case boolean(Bool)
}
