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
    
    private var selectedRow: Int = 0
    
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
        
        if selectedRow == 0 && indexPath.row == 0 {
            cell.bind(state: .selected)
            delegate?.tableView(didSelectSport: viewModel)
        } else if selectedRow > 0 && selectedRow == indexPath.row {
            cell.bind(state: .selected)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

//MARK: - UITableViewDelegate -

extension SportTypeListDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        let selectedIndexPath = IndexPath(row: selectedRow, section: 0)
        
        if indexPath.row == 0 {
            let selectedCell: TableViewSportTypeListCell = tableView.cell(forRowAt: selectedIndexPath)
            selectedCell.bind(state: .notSelected)
            
            let newCell: TableViewSportTypeListCell = tableView.cell(forRowAt: indexPath)
            newCell.bind(state: .selected)
            
            selectedRow = indexPath.row
            
        } else if indexPath.row != selectedRow && indexPath.row > 0 {
            let selectedCell: TableViewSportTypeListCell = tableView.cell(forRowAt: selectedIndexPath)
            selectedCell.bind(state: .notSelected)
            
            let newCell: TableViewSportTypeListCell = tableView.cell(forRowAt: indexPath)
            newCell.bind(state: .selected)
            
            selectedRow = indexPath.row
            
            delegate?.tableView(didSelectSport: viewModel)
        }
        
        tableView.reloadRows(at: [indexPath, selectedIndexPath], with: .middle)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
