//
//  CountryCodeListViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 29/12/2020.
//

import Foundation

final class CountryCodeListViewModel {
    
    var onSectionsDidSet: (([CountryCodeListSectionModel]) -> Swift.Void)?
    var onCountryDidNotMatch: (() -> Swift.Void)?
    
    var countries: [Country]? {
        didSet {
            prepareCountriesByOrderedSections(using: self.countries)
        }
    }
    
    var sections: [CountryCodeListSectionModel]? {
        didSet {
            if let sections = sections, sections.count != 0 {
                onSectionsDidSet?(sections)
            } else {
                onCountryDidNotMatch?()
            }
        }
    }
    
    init() {
        
    }
    
    func loadCountries() {
        self.countries = loadJson(fileName: "CountryList")
    }
    
    func prepareCountriesToSearch(by preffix: String) {
        let newCountryList = countries?.compactMap { country -> Country? in
            if country.name?.lowercased().hasPrefix(preffix.lowercased()) == true {
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
        
        sections = keys.compactMap { CountryCodeListSectionModel(
            letter: $0,
            countries: groupedDictionary[$0]!.sorted(by: { $0.name ?? "" > $1.name ?? "" })
        )}
    }
}
