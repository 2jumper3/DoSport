//
//  NetworkSuccessResponseType.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 21/03/2021.
//

import Foundation

enum NetworkSuccessResponseType<ResponseObject> where ResponseObject: Codable {
    case object(ResponseObject)
    case emptyObject
}
