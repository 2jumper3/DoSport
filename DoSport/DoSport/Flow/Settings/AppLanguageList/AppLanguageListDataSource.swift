//
//  AppLanguageListDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

protocol AppLanguageListDataSourceDelegate: class {
    func tableView(didSelect language: AppLanguageModel.Language)
}

/// Describes AppLanguage screen's table data souce object
final class AppLanguageListDataSource: NSObject {
    
    weak var delegate: AppLanguageListDataSourceDelegate?
    
    var viewModels: [AppLanguageModel.Language] = []
    
    override init() {
        super.init()
        
    }
}

//MARK: - UITableViewDataSource -

extension AppLanguageListDataSource:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let language: AppLanguageModel.Language = viewModels[indexPath.row]
        let cell: SportTypeListTableCell = tableView.cell(forRowAt: indexPath)
        cell.textLabel?.text = language.name
        cell.bind(isChoosen: language.isChoosen)

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = Colors.dirtyBlue
        label.font = Fonts.sfProRegular(size: CGFloat(17))
        label.text = Texts.Common.language
        return label
    }
}

//MARK: - UITableViewDelegate -

extension AppLanguageListDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let language = viewModels[indexPath.row]
        
        delegate?.tableView(didSelect: language)
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

