//
//  MainViewModel.swift
//  DoSport
//
//  Created by MAC on 14.01.2021.
//

import Foundation

protocol TypeSportsListViewModelProtocol: class {
    var countTypeSports: [SportTypeModel] { get }
    var fillteredTypeSports: [SportTypeModel] { get }
    var searching: Bool { get }
    func returnCountOfItemsCollectionView() -> Int
    func searchTypeOfSports(text: String, string: String, completion: ()->())
}

final class TypeSportsListViewModel: TypeSportsListViewModelProtocol  {

    var countTypeSports: [SportTypeModel] = []
    var fillteredTypeSports: [SportTypeModel] = []
    var searching: Bool = false
    private var searchText: String = ""

    init() {
        fetchCountTypeOfSport()
    }

    func returnCountOfItemsCollectionView() -> Int {
        return searching == true ? fillteredTypeSports.count : countTypeSports.count
    }

    func searchTypeOfSports(text: String, string: String, completion: ()->()) {
        searchText = text + string
        if string  == "" {
            let range = searchText.startIndex..<searchText.index(before: searchText.endIndex)
            searchText = String(searchText[range])
        }
        if searchText == "" {
            searching = false
            completion()
        } else {
            getSearchArrayContains(searchText, completion: completion)
        }
    }

    private func getSearchArrayContains(_ text : String, completion: ()->()) {
        fillteredTypeSports = countTypeSports.filter({ (model) -> Bool in
            return model.titleType.lowercased().contains(text.lowercased())
        })
        searching = true
        completion()
    }

    private func fetchCountTypeOfSport() {
        let typesOfSports = SportTypeModel.returnSportTypeModelsList()
        self.countTypeSports = typesOfSports
    }
}
