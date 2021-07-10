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
    func tableViewDidSelectSportGroundCell(completion: @escaping (DSModels.SportGround.SportGroundResponse) -> Void)
    
    /// When tapped to date select cell, user goes to `DateSelection` screen. When user selects date and clicks save button
    ///  then `DateSelection` screen calls completion with selected date string before going back.
    func tableViewDidSelectDateSelectionCell(for sportGround: DSModels.SportGround.SportGroundResponse?, completion: @escaping (String) -> Void)
    
    func tableViewSportTypeCell(didSetTitle title: String)
    func tableViewSportGroudnCell(didSetTitle title: String)
    func tableViewDateSelectionCellDidSetTitle()
}

final class EventCreateDataSource: NSObject {
    
    weak var delegate: EventCreateDataSourceDelegate?
    
    private enum CellType: String, CaseIterable {
        case textView, sportTypeSelection, sportGroundSelection, dateSelection/*, membersCount, eventType*/
    }
    
    private var cells: [CellType] = CellType.allCases
    
    private var sportGround: DSModels.SportGround.SportGroundResponse?
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
        case .sportGroundSelection:
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
//        case .membersCount:
//            let membersCountCell: MembersCountCell = tableView.cell(forRowAt: indexPath)
//            cell = membersCountCell
//
//        case .eventType:
//            let eventTypeCell: EventTypeCell = tableView.cell(forRowAt: indexPath)
//            cell = eventTypeCell
        }
        
        cell.backgroundColor = Colors.darkBlue
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - UITableViewDelegate -

extension EventCreateDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType: CellType = cells[indexPath.row]
        
        guard
            let cell: SelectionCell = tableView.cellForRow(at: indexPath) as? SelectionCell
        else {
            return
        }
        
        switch cellType {
        case .sportTypeSelection:
            delegate?.tableViewDidSelectSportTypeCell { selectedSportTypeTitle in
                cell.bind(selectedSportTypeTitle)
            }
        case .sportGroundSelection:
            delegate?.tableViewDidSelectSportGroundCell { selectedSportGround in
                cell.bind(selectedSportGround.title ?? "")
                self.sportGround = selectedSportGround
            }
            
        case .dateSelection:
            delegate?.tableViewDidSelectDateSelectionCell(for: sportGround) { selectedDateTitle in
                cell.bind(selectedDateTitle)
            }
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = tableView.frame.height * 0.26
        var selectionHeight: CGFloat = 50
//        var membersCountHeight: CGFloat = 208
        let cellType: CellType = cells[indexPath.row]
        
        switch UIDevice.deviceSize {
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2:
            break
        /*membersCountHeight = 200*/
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini: selectionHeight = 55
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max:
            selectionHeight = 60
//            membersCountHeight = 220
        }
        
        switch cellType {
        case .textView: return height
        case .sportTypeSelection: return selectionHeight
        case .sportGroundSelection: return selectionHeight
        case .dateSelection: return selectionHeight
//        case .membersCount: return membersCountHeight
//        case .eventType: return selectionHeight
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { nil }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 0 }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView = EventTypeTableCellFooter()
//        return footerView
//    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 55
//    }
}
