//
//  LoadJson.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import Foundation

func loadJson(fileName: String) -> [Country]? {
    let decoder = JSONDecoder()
                                            
    guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
        return nil
    }
    
    do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let countyList = try? decoder.decode(CountryList.self, from: data)
        
        return countyList?.countries
    } catch let error {
        print(error.localizedDescription)
    }
    
    return nil
}
