//
//  SettingsDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import UIKit

protocol SettingsDataSourceDelegate: class {
    func tableView(didSelect cellType: SettingCellType)
}

enum SettingCellType {
    case account(icon: UIImage?, title: String?)
    case alerts(icon: UIImage?, title: String?)
    case privacy(icon: UIImage?, title: String?)
    case language(icon: UIImage?, title: String?)
    case help(icon: UIImage?, title: String?)
}

final class SettingsDataSource: NSObject {
    
    weak var delegate: SettingsDataSourceDelegate?
    
    private let settingCells: [SettingCellType] = [
        .account(icon: Icons.Settings.user, title: Texts.Settings.account),
        .alerts(icon: Icons.Settings.alertBell, title: Texts.Settings.alerts),
        .privacy(icon: Icons.Settings.lock, title: Texts.Settings.privacy),
        .language(icon: Icons.Settings.globe, title: Texts.Settings.language),
        .help(icon: Icons.Settings.helpCircle, title: Texts.Settings.help)
    ]
    
    override init() {
        super.init()

    }
}

//MARK: - UITableViewDataSource -

extension SettingsDataSource:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingCellType: SettingCellType = settingCells[indexPath.row]
        let cell: SettingsTableCell
        
        switch settingCellType {
        case .account(let icon, let title):
            let accountCell: SettingsTableCell = tableView.cell(forRowAt: indexPath)
            accountCell.bind(with: .init(icon: icon, title: title))
            cell = accountCell
        case .alerts(let icon, let title):
            let alertsCell: SettingsTableCell = tableView.cell(forRowAt: indexPath)
            alertsCell.bind(with: .init(icon: icon, title: title))
            cell = alertsCell
        case .privacy(let icon, let title):
            let privacyCell: SettingsTableCell = tableView.cell(forRowAt: indexPath)
            privacyCell.bind(with: .init(icon: icon, title: title))
            cell = privacyCell
        case .language(let icon, let title):
            let languageCell: SettingsTableCell = tableView.cell(forRowAt: indexPath)
            languageCell.bind(with: .init(icon: icon, title: title))
            cell = languageCell
        case .help(let icon, let title):
            let helpCell: SettingsTableCell = tableView.cell(forRowAt: indexPath)
            helpCell.bind(with: .init(icon: icon, title: title))
            cell = helpCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}

//MARK: - UITableViewDelegate -

extension SettingsDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCellType: SettingCellType = settingCells[indexPath.row]
        
        switch selectedCellType {
        case .account: delegate?.tableView(didSelect: .account(icon: nil, title: Texts.Settings.account))
        case .alerts: delegate?.tableView(didSelect: .alerts(icon: nil, title: Texts.Settings.alerts))
        case .privacy: delegate?.tableView(didSelect: .privacy(icon: nil, title: Texts.Settings.privacy))
        case .language: delegate?.tableView(didSelect: .language(icon: nil, title: Texts.Settings.language))
        case .help: delegate?.tableView(didSelect: .help(icon: nil, title: Texts.Settings.help))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat
        
        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2: height = 50
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini: height = 55
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max: height = 55
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
}
