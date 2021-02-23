//
//  DateSelectionDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

protocol DateSelectionDataSourceDelegate: class {
    func collectionView(didSelect hour: String)
    func collectionView(didCancelSelection hour: String)
    func collectionViewAfterClearAll(didSelect hour: String)
}

final class DateSelectionDataSource: NSObject {
    
    weak var delegate: DateSelectionDataSourceDelegate?
    
    var defaultHours: [String]
    var notAvailableHours: [String] = []
    var selectedHours: [Int: String] = [:]
    
    init(defaultHours: [String] = []) {
        self.defaultHours = defaultHours
        super.init()
    }
}

//MARK: Private API

private extension DateSelectionDataSource {
    
    func clearPreviousSelectedHours(for collectionView: UICollectionView) {
        selectedHours.keys.forEach { key in
            let indexPath = IndexPath(row: key, section: 0)
            
            guard
                let cell = collectionView.cellForItem(at: indexPath)
                    as? CollectionViewHoursCell
            else {
                return
            }
            
            cell.bind(state: .available(false))
        }
        
        selectedHours.removeAll()
    }
}

//MARK: - UITableViewDataSource -

extension DateSelectionDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        defaultHours.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let defaultHour = defaultHours[indexPath.row]
        
        let cell: CollectionViewHoursCell = collectionView.cell(forRowAt: indexPath)
        cell.myTitleLabel.text = defaultHour
        cell.bind(state: .available(false))
        
        if notAvailableHours.count > 0 {
            notAvailableHours.forEach { notAvailableHour in
                if notAvailableHour == defaultHour {
                    cell.bind(state: .notAvailable)
                }
            }
        }
        
        if selectedHours.count > 0 {
            selectedHours.values.forEach { selectedHour in
                if selectedHour == defaultHour {
                    cell.bind(state: .available(true))
                }
            }
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate -

extension DateSelectionDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let defaultHour = defaultHours[indexPath.row]
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewHoursCell else {
            return
        }
    
        if cell.cellState == .available(false) {
            
            if selectedHours.count > 0 {
                
                if selectedHours[indexPath.row - 1] != nil {
                    cell.bind(state: .available(true))
                    selectedHours[indexPath.row] = defaultHour
                    delegate?.collectionView(didSelect: defaultHour)
                } else {
                    clearPreviousSelectedHours(for: collectionView)
                    cell.bind(state: .available(true))
                    selectedHours[indexPath.row] = defaultHour
                    delegate?.collectionViewAfterClearAll(didSelect: defaultHour)
                }
                 
            } else {
                cell.bind(state: .available(true))
                selectedHours[indexPath.row] = defaultHour
                delegate?.collectionView(didSelect: defaultHour)
            }
            
        } else if cell.cellState == .available(true) {
            cell.bind(state: .available(false))
            selectedHours.removeValue(forKey: indexPath.row)
            delegate?.collectionView(didCancelSelection: defaultHour)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout -

extension DateSelectionDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellHeight = UIDevice.deviceSize == .small ? (collectionView.frame.height/6) : (collectionView.frame.height/8)
        
        return CGSize(width: collectionView.frame.width * 0.31, height: cellHeight-2)
    }
}
