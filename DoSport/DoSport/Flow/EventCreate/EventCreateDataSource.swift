//
//  EventCreateDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

final class EventCreateDataSource: NSObject {
    
    var onDidTapSportTypeCell: ((UITableViewCell) -> Void)?
    var onDidTapPlaygroundCell: ((UITableViewCell, String?) -> Void)?
    var onDidTapDateCell: ((UITableViewCell, String?) -> Void)?
    var onDidTapCheckboxButton: ((DSCheckboxButton) -> Void)?
    var onDidTapDoneButton: ((UITextView) -> Void)?
    
    var onSportTypeCellDidChangeState:((SelectionCell.CellState) -> Void)?
    var onPlaygroundCellDidChangeState:((SelectionCell.CellState) -> Void)?
    var onDateSelecteCellDidChangeState:((SelectionCell.CellState) -> Void)?
    
    private enum CellType: String, CaseIterable {
        case textView, sportTypeSelection, playgroundSelection, dateSelection, membersCount, eventType
    }
    
    private var cells: [CellType] = CellType.allCases
    
    /// to provide title to the playground selection screen in order to define sport type. Used when tapped
    /// playground selection cell in this class's delegate part below
    private var sportTypeTitle: String?
    
    /// to provide title to the date selection screen in order to define in what playground user can book time.
    /// Uused when tapped date selection cell in this class's delegate part below
    private var playgroundTitle: String?
}

//MARK: - Actions

@objc
private extension EventCreateDataSource {
    
    func handleCheckboxButton(_ button: DSCheckboxButton) {
        onDidTapCheckboxButton?(button)
    }
}

//MARK: - UITableViewDataSource

extension EventCreateDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return cells.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let cellType: CellType = cells[indexPath.row]
        
        switch cellType {
        case .textView:
            let textViewCell: TextViewCell = tableView.cell(forRowAt: indexPath)
            // почему unowned? хз. изучить какие ссылки между ячейками и датаСурс
            textViewCell.onDidTapDoneButton = { [unowned self] textView in
                self.onDidTapDoneButton?(textView)
            }
            
            cell = textViewCell
        case .sportTypeSelection:
            let sportSelectionCell: SelectionCell = tableView.cell(forRowAt: indexPath)
            sportSelectionCell.bind(Texts.EventCreate.sportTypes)
            sportSelectionCell.onDidChangeState = { [unowned self] state in
                self.onSportTypeCellDidChangeState?(state)
            }
            
            sportSelectionCell.onDidChangeTitle = { [unowned self] newTitle in
                self.sportTypeTitle = newTitle
            }
            
            cell = sportSelectionCell
        case .playgroundSelection:
            let playgroundSelectionCell: SelectionCell = tableView.cell(forRowAt: indexPath)
            playgroundSelectionCell.bind(Texts.EventCreate.playground)
            playgroundSelectionCell.onDidChangeState = { [unowned self] state in
                self.onPlaygroundCellDidChangeState?(state)
            }
            
            playgroundSelectionCell.onDidChangeTitle = { [unowned self] newTitle in
                self.playgroundTitle = newTitle
            }
            
            cell = playgroundSelectionCell
        case .dateSelection:
            let dateSelectionCell: SelectionCell = tableView.cell(forRowAt: indexPath)
            dateSelectionCell.bind(Texts.EventCreate.date)
            dateSelectionCell.onDidChangeState = { [unowned self] state in
                self.onDateSelecteCellDidChangeState?(state)
            }
            
            cell = dateSelectionCell
        case .membersCount:
            let membersCountCell: MembersCountCell = tableView.cell(forRowAt: indexPath)
            membersCountCell.checkboxButton.addTarget(self, action: #selector(handleCheckboxButton), for: .touchUpInside)
            
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
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        switch cellType {
        case .sportTypeSelection: onDidTapSportTypeCell?(cell)
        case .playgroundSelection: onDidTapPlaygroundCell?(cell, sportTypeTitle)
        case .dateSelection: onDidTapDateCell?(cell, playgroundTitle)
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
