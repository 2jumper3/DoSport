//
//  LoadJson.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import Foundation

func loadJson(fileName: String) -> [Country]? {
    let decoder = JSONDecoder()
    guard
        let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
        let data = try? Data(contentsOf: url),
        let countyList = try? decoder.decode(CountryList.self, from: data)
    else {
        return nil
    }
    
    return countyList.countries
}
