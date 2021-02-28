//
//  NotificationSettingsDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

protocol NotificationSettingsDataSourceDelegate: class {
    func tableViewDidSelectSoundCell()
}

final class NotificationSettingsDataSource: NSObject {
    
    private enum NotificationSettingsSectionType: String, CaseIterable {
        case messageNotifications, eventsNotification, newEventsNotifications
        
        var title: String {
            switch self {
            case .messageNotifications: return Texts.NotificationSettings.sectionOneTitle
            case .eventsNotification: return Texts.NotificationSettings.secondSectionTitle
            case .newEventsNotifications: return ""
            }
        }
    }
    
    private enum NotificationSettingsCellType: String, CaseIterable {
        case showAlert, showText, sound, groundEvents, usersEvents, newGrounds, newEvents
        
        var title: String {
            switch self {
            case .showAlert: return Texts.NotificationSettings.showNotifications
            case .showText: return Texts.NotificationSettings.showText
            case .sound: return Texts.NotificationSettings.sound
            case .groundEvents: return Texts.NotificationSettings.groundEvents
            case .usersEvents: return Texts.NotificationSettings.usersEvents
            case .newGrounds: return Texts.NotificationSettings.newGroundsAround
            case .newEvents: return Texts.NotificationSettings.newEventsAround
            }
        }
    }
    
    weak var delegate: NotificationSettingsDataSourceDelegate?
    
    private let notificationSettingsCells: [String]
    private let notificationSettingsSections: [String]
    
    override init() {
        self.notificationSettingsCells = NotificationSettingsCellType.allCases.map { $0.title }
        self.notificationSettingsSections = NotificationSettingsSectionType.allCases.map { $0.title }
        super.init()
    }
}

//MARK: - UITableViewDataSource -

extension NotificationSettingsDataSource:  UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return notificationSettingsSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 3
        case 1: return 2
        case 2: return 2
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellText: String = notificationSettingsCells[indexPath.row]
        let cell: UITableViewCell
        
        if indexPath.section == 0 && indexPath.row == 2 {
            let regularCell: RegularTableCellWithPointer = tableView.cell(forRowAt: indexPath)
            regularCell.textLabel?.text = cellText
    
            cell = regularCell
        } else {
            let cellWithSwitch: NotificationSettingsTableCell = tableView.cell(forRowAt: indexPath)
            cellWithSwitch.textLabel?.text = cellText
            cell = cellWithSwitch
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionText = notificationSettingsSections[section]
        let label = UILabel()
        label.numberOfLines = Int(2)
        label.textColor = Colors.dirtyBlue
        label.font = Fonts.sfProRegular(size: CGFloat(18))
        label.text = sectionText
        return label
    }
}

//MARK: - UITableViewDelegate -

extension NotificationSettingsDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 2 {
            delegate?.tableViewDidSelectSoundCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat
        
        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2: height = CGFloat(55.0)
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini: height = CGFloat(55)
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max: height = CGFloat(55)
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return CGFloat(55.0)
        case 1: return CGFloat(85.0)
        case 2: return CGFloat(30.0)
        default: return CGFloat(0.0)
        }
    }
}
