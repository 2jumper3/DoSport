//
//  UserSupportSettingsDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

protocol UserSupportSettingsDataSourceDelegate: class {
    func tableView(didSelect userSupportCell: UserSupportCellType)
}

enum UserSupportCellType: String, CaseIterable {
    case problemReport, supportRequest, dataUsagePolicy, appUsagePolicy
    
    var title: String {
        switch self {
        case .problemReport: return Texts.UserSupportSettings.reportAProblem
        case .supportRequest: return Texts.UserSupportSettings.supportRequest
        case .dataUsagePolicy: return Texts.UserSupportSettings.dataUsagePolicy
        case .appUsagePolicy: return Texts.UserSupportSettings.appUsagePolicy
        }
    }
}

final class UserSupportSettingsDataSource: NSObject {
    
    weak var delegate: UserSupportSettingsDataSourceDelegate?
    
    private let viewModels: [UserSupportCellType]
    
    override init() {
        self.viewModels = UserSupportCellType.allCases.map { $0 }
        super.init()
        
    }
}

//MARK: - UITableViewDataSource -

extension UserSupportSettingsDataSource:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType: UserSupportCellType = viewModels[indexPath.row]
        let cell: RegularTableCellWithPointer = tableView.cell(forRowAt: indexPath)
        cell.textLabel?.text = cellType.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}

//MARK: - UITableViewDelegate -

extension UserSupportSettingsDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType: UserSupportCellType = viewModels[indexPath.row]
        
        switch cellType {
        case .problemReport: delegate?.tableView(didSelect: .problemReport)
        case .supportRequest: delegate?.tableView(didSelect: .supportRequest)
        case .dataUsagePolicy: delegate?.tableView(didSelect: .dataUsagePolicy)
        case .appUsagePolicy: delegate?.tableView(didSelect: .appUsagePolicy)
        }
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
        return CGFloat(0.0)
    }
}
