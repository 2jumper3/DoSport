//
//  DSDecoder+decode.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/03/2021.
//

import Foundation

extension Date {
    static let DS_DateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
}

extension JSONDecoder {

    // if you touch date things, app response may break  on real devices
    static func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        let decoder = JSONDecoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.DS_DateFormat
        dateFormatter.locale = Locale(identifier: "ru_RU_POSIX")
        
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try decoder.decode(T.self, from: data)
    }
}
