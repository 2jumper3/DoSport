//
//  CountryListDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 29/12/2020.
//

import UIKit

final class CountryListDataSource: NSObject {
    
    var onCountryDidSelect: ((Country) -> Swift.Void)?
    
    var viewModels: [CountryListTableCellSectionModel]
    
    init(viewModels: [CountryListTableCellSectionModel] = []) {
        self.viewModels = viewModels
        super.init()
    }
}


//MARK: - UITableViewDataSource

extension CountryListDataSource: UITableViewDataSource {
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
        return CountryListTableCellHeaderView(title: viewModels[section].letter)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CountryListTableCell = tableView.cell(forRowAt: indexPath)
        cell.updateConstraintsIfNeeded()
        
        let viewModel = viewModels[indexPath.section].countries[indexPath.row]
        cell.bind(country: viewModel)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension CountryListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.section].countries[indexPath.row]
        onCountryDidSelect?(viewModel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height * 0.1
    }
}



