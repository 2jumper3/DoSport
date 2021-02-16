//
//  SportTypeListDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 13/02/2021.
//

import UIKit

protocol SportTypeListDataSourceDelegate: class {
    func tableView(didSelectSport sport: Sport)
}

final class SportTypeListDataSource: NSObject {
    
    weak var delegate: SportTypeListDataSourceDelegate?
    
    var viewModels: [Sport]
    
    private var selectedCell: TableViewSportTypeListCell?
    
    init(viewModels: [Sport] = []) {
        self.viewModels = viewModels
        super.init()
        
    }
}

//MARK: - UITableViewDataSource -

extension SportTypeListDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        
        let cell: TableViewSportTypeListCell = tableView.cell(forRowAt: indexPath)
        cell.myTitleLabel.text = viewModel.title
        
        return cell
    }
}

//MARK: - UITableViewDelegate -

extension SportTypeListDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        
        if let cell = tableView.cellForRow(at: indexPath) as? TableViewSportTypeListCell,
           cell.cellState == .notSelected {
            selectedCell?.bind(state: .notSelected)
            cell.bind(state: .selected)
            selectedCell = cell
        }
        
        delegate?.tableView(didSelectSport: viewModel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
