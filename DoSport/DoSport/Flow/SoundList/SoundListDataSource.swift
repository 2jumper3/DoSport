//
//  SoundListDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

protocol SoundListDataSourceDelegate: class {
    func tableView(didSelect sound: String)
}

final class SoundListDataSource: NSObject {
    
    weak var delegate: SoundListDataSourceDelegate?
    
    private let viewModels: [String]
    private var selectedRow: Int = 0
    
    init(viewModels: [String] = []) {
        self.viewModels = DSNotificationSound.NotificationSoundType.allCases.map { $0.title }
        super.init()
        
    }
}

//MARK: - UITableViewDataSource -

extension SoundListDataSource:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sound: String = viewModels[indexPath.row]
        let cell: SportTypeListTableCell = tableView.cell(forRowAt: indexPath)
        cell.titleText = sound
        cell.bind(state: .notSelected)
        
        if selectedRow == 0 && indexPath.row == 0 {
            cell.bind(state: .selected)
            delegate?.tableView(didSelect: sound)
        } else if selectedRow > 0 && selectedRow == indexPath.row {
            cell.bind(state: .selected)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = Colors.dirtyBlue
        label.font = Fonts.sfProRegular(size: CGFloat(17))
        label.text = Texts.SoundList.tableSection
        return label
    }
}

//MARK: - UITableViewDelegate -

extension SoundListDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sound = viewModels[indexPath.row]
        let selectedIndexPath = IndexPath(row: selectedRow, section: 0)
        let selectedCell: SportTypeListTableCell
        let newCell: SportTypeListTableCell
        
        if indexPath.row == 0 {
            selectedCell = tableView.cell(forRowAt: selectedIndexPath)
            selectedCell.bind(state: .notSelected)
            
            newCell = tableView.cell(forRowAt: indexPath)
            newCell.bind(state: .selected)
            
            selectedRow = indexPath.row
            
        } else if indexPath.row != selectedRow && indexPath.row > 0 {
            selectedCell = tableView.cell(forRowAt: selectedIndexPath)
            selectedCell.bind(state: .notSelected)
            
            newCell = tableView.cell(forRowAt: indexPath)
            newCell.bind(state: .selected)
            
            selectedRow = indexPath.row
        }
        
        delegate?.tableView(didSelect: sound)
        tableView.reloadRows(at: [indexPath, selectedIndexPath], with: .none)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat
        
        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2: height = CGFloat(50)
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini: height = CGFloat(55)
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max: height = CGFloat(55)
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height: CGFloat
        
        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2: height = CGFloat(50)
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini: height = CGFloat(55)
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max: height = CGFloat(55)
        }
        
        return height
    }
}

