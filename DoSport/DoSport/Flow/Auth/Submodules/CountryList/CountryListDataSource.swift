//
//  CountryListDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 29/12/2020.
//

import UIKit

final class CountryListDataSource: NSObject {
    
    var onCountryDidSelect: ((Country) -> Swift.Void)?
    
    var viewModels: [Country]
    
    init(viewModels: [Country] = []) {
        self.viewModels = viewModels
        super.init()
    }
}


//MARK: - UITableViewDataSource

extension CountryListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CountryListTableCell = tableView.cell(forRowAt: indexPath)
        cell.updateConstraintsIfNeeded()
        
        let viewModel = viewModels[indexPath.row]
        cell.bind(country: viewModel)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension CountryListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        onCountryDidSelect?(viewModel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height * 0.1
    }
}



