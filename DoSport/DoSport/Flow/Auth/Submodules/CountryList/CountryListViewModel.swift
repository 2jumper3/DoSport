//
//  CountryListViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 29/12/2020.
//

import Foundation

final class CountryListViewModel {
    
    var onCountriesDidLoad: (([Country]) -> Swift.Void)?
    
    var countries: [Country]? {
        didSet {
            guard let countries = countries else { return }
            onCountriesDidLoad?(countries)
        }
    }
    
    init() {
        
    }
    
    func loadCountries() {
        self.countries = loadJson(fileName: "CountryList")
    }
}
