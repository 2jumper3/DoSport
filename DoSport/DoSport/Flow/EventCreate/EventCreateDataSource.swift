//
//  EventCreateDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

protocol EventCreateDataSourceDelegate: class {
    /// When tapped to sport type select cell, user goes to `SportTypeList` screen. When user selects sport type and clicks select button
    ///  then `SportTypeList` screen calls completion with selected sport type title before going back.
    func tableViewDidSelectSportTypeCell(completion: @escaping (String) -> Void)
    
    /// When tapped to date select cell, user goes to `SportGroundSelectionList` screen. When user selects sport ground
    ///  then `SportGroundSelectionList` screen calls completion with selected sport ground string before going back.
    func tableViewDidSelectSportGroundCell(completion: @escaping (String) -> Void)
    
    /// When tapped to date select cell, user goes to `DateSelection` screen. When user selects date and clicks save button
    ///  then `DateSelection` screen calls completion with selected date string before going back.
    func tableViewDidSelectDateSelectionCell(completion: @escaping (String) -> Void)
    
    func tableViewSportTypeCell(didSetTitle title: String)
    func tableViewSportGroudnCell(didSetTitle title: String)
    func tableViewDateSelectionCellDidSetTitle()
}

final class EventCreateDataSource: NSObject {
    
    weak var delegate: EventCreateDataSourceDelegate?
    
    private enum CellType: String, CaseIterable {
        case textView, sportTypeSelection, playgroundSelection, dateSelection, membersCount, eventType
    }
    
    private var cells: [CellType] = CellType.allCases
}

//MARK: - UITableViewDataSource -

extension EventCreateDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let cellType: CellType = cells[indexPath.row]
        
        switch cellType {
        case .textView:
            let textViewCell: TextViewCell = tableView.cell(forRowAt: indexPath)
            cell = textViewCell
            
        case .sportTypeSelection:
            let sportSelectionCell: SelectionCell = tableView.cell(forRowAt: indexPath)
            sportSelectionCell.bind(Texts.EventCreate.sportTypes)
            sportSelectionCell.onTitleDidSet = { [unowned self] title in
                self.delegate?.tableViewSportTypeCell(didSetTitle: title)
            }
            
            cell = sportSelectionCell
        case .playgroundSelection:
            let playgroundSelectionCell: SelectionCell = tableView.cell(forRowAt: indexPath)
            playgroundSelectionCell.bind(Texts.EventCreate.playground)
            playgroundSelectionCell.onTitleDidSet = { [unowned self] title in
                self.delegate?.tableViewSportGroudnCell(didSetTitle: title)
            }
            
            cell = playgroundSelectionCell
        case .dateSelection:
            let dateSelectionCell: SelectionCell = tableView.cell(forRowAt: indexPath)
            dateSelectionCell.bind(Texts.EventCreate.date)
            dateSelectionCell.onTitleDidSet = { [unowned self] _ in
                self.delegate?.tableViewDateSelectionCellDidSetTitle()
            }
            
            cell = dateSelectionCell
        case .membersCount:
            let membersCountCell: MembersCountCell = tableView.cell(forRowAt: indexPath)
            cell = membersCountCell
            
        case .eventType:
            let eventTypeCell: EventTypeCell = tableView.cell(forRowAt: indexPath)
            cell = eventTypeCell
        }
        
        cell.backgroundColor = Colors.darkBlue
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - UITableViewDelegate

extension EventCreateDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType: CellType = cells[indexPath.row]
        
        guard
            let cell: SelectionCell = tableView.cellForRow(at: indexPath) as? SelectionCell
        else {
            return
        }
        
        switch cellType {
        case .sportTypeSelection: delegate?.tableViewDidSelectSportTypeCell { cell.bind($0) }
        case .playgroundSelection: delegate?.tableViewDidSelectSportGroundCell { cell.bind($0) }
        case .dateSelection: delegate?.tableViewDidSelectDateSelectionCell { cell.bind($0) }
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat
        let cellType: CellType = cells[indexPath.row]
        
        switch cellType {
        case .textView: height = tableView.frame.height * 0.27
        case .sportTypeSelection: height = tableView.frame.height * 0.095
        case .playgroundSelection: height = tableView.frame.height * 0.095
        case .dateSelection: height = tableView.frame.height * 0.095
        case .membersCount: height = tableView.frame.height * 0.38
        case .eventType: height = tableView.frame.height * 0.13
        }
        
        return height
    }
}
