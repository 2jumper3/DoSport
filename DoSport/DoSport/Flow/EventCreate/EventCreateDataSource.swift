//
//  EventCreateDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

final class EventCreateDataSource: NSObject {
    
    var onDidTapSportTypeCell: (() -> Void)?
    var onDidTapPlaygroundCell: (() -> Void)?
    var onDidTapDateCell: (() -> Void)?
    var onDidTapCheckboxButton: ((DSCheckboxButton) -> Void)?
    var onDidTapDoneButton: ((UITextView) -> Void)?
    
    private enum CellType: String, CaseIterable {
        case textView, sportTypeSelection, playgroundSelection, dateSelection, membersCount, eventType
    }
    
    private var cells: [CellType] = CellType.allCases
}

//MARK: - Public Methods

extension EventCreateDataSource { }

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
            textViewCell.onDidTapDoneButton = { [unowned self] textView in
                self.onDidTapDoneButton?(textView)
            }
            
            cell = textViewCell
        case .sportTypeSelection:
            let sportSelectionCell: SelectionCell = tableView.cell(forRowAt: indexPath)
            sportSelectionCell.myTitleLabel.text = Texts.EventCreate.sportTypes
            
            cell = sportSelectionCell
        case .playgroundSelection:
            let playgroundSelectionCell: SelectionCell = tableView.cell(forRowAt: indexPath)
            playgroundSelectionCell.myTitleLabel.text = Texts.EventCreate.playground
            
            cell = playgroundSelectionCell
        case .dateSelection:
            let dateSelectionCell: SelectionCell = tableView.cell(forRowAt: indexPath)
            dateSelectionCell.myTitleLabel.text = Texts.EventCreate.date
            
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
        
        switch cellType {
        case .sportTypeSelection: onDidTapSportTypeCell?()
        case .playgroundSelection: onDidTapPlaygroundCell?()
        case .dateSelection: onDidTapDateCell?()
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
