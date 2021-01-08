//
//  CountryListViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 29/12/2020.
//

import Foundation

final class CountryListViewModel {
    
    var onCountriesDidLoad: (([Country]) -> Swift.Void)?
    var onSectionsDidSet: (([CountryListTableCellSectionModel]) -> Swift.Void)?
    
    var countries: [Country]? {
        didSet {
            prepareCountriesByOrderedSections(using: self.countries)
        }
    }
    
    var sections: [CountryListTableCellSectionModel]? {
        didSet {
            guard let sections = sections else { return }
            onSectionsDidSet?(sections)
        }
    }
    
    init() {
        
    }
    
    func loadCountries() {
        self.countries = loadJson(fileName: "CountryList")
    }
    
    func prepareCountriesToSearch(by preffix: String) {
        let newCountryList = countries?.compactMap { country -> Country? in
            if country.name?.hasPrefix(preffix) == true {
                return country
            } else {
                return nil
            }
        }
        prepareCountriesByOrderedSections(using: newCountryList)
    }
    
    private func prepareCountriesByOrderedSections(using countryList: [Country]?) {
        guard let countryList = countryList else { return }
        
        let groupedDictionary = Dictionary(
            grouping: countryList,
            by: { String($0.name?.prefix(1) ?? "") }
        )
        
        let keys = groupedDictionary.keys.sorted()
        
        sections = keys.compactMap { CountryListTableCellSectionModel(
            letter: $0,
            countries: groupedDictionary[$0]!.sorted(by: { $0.name ?? "" > $1.name ?? "" })
        )}
    }
}
