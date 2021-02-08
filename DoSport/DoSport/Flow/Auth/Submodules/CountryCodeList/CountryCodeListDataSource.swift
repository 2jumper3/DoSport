//
//  CountryCodeListDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 29/12/2020.
//

import UIKit

final class CountryCodeListDataSource: NSObject {
    
    var onCountryDidSelect: ((Country) -> Swift.Void)?
    
    var viewModels: [CountryCodeListSectionModel]
    
    init(viewModels: [CountryCodeListSectionModel] = []) {
        self.viewModels = viewModels
        super.init()
    }
}

//MARK: - UITableViewDataSource

extension CountryCodeListDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels[section].countries.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        viewModels.map { $0.letter }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TableViewCellsHeaderView(title: viewModels[section].letter)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCountryCell = tableView.cell(forRowAt: indexPath)
        cell.updateConstraintsIfNeeded()
        
        let viewModel = viewModels[indexPath.section].countries[indexPath.row]
        cell.bind(country: viewModel)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension CountryCodeListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.section].countries[indexPath.row]
        onCountryDidSelect?(viewModel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height * 0.1
    }
}



