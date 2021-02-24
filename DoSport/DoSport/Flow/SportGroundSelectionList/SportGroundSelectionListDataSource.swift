//
//  SportGroundSelectionListDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import UIKit

protocol SportGroundSelectionListDataSourceDelegate: class {
    func tableView(didSelect sportGround: SportGround)
}

final class SportGroundSelectionListDataSource: NSObject {
    
    weak var delegate: SportGroundSelectionListDataSourceDelegate?
    
    var viewModels: [SportGround]
    
    private var selectedCell: SportTypeListTableCell?
    
    init(viewModels: [SportGround] = []) {
        self.viewModels = viewModels
        super.init()
        
    }
}

//MARK: - UITableViewDataSource -

extension SportGroundSelectionListDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        
        let cell: SportGroundSelectionTableCell = tableView.cell(forRowAt: indexPath)
        cell.bind(with: .init(
                    sportGroundTitle: viewModel.title,
                    spogroundBackImage: nil,
                    subwayName: viewModel.address,
                    location: nil,
                    price: nil))
        
        return cell
    }
}

//MARK: - UITableViewDelegate -

extension SportGroundSelectionListDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        
        delegate?.tableView(didSelect: viewModel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.2
    }
}

