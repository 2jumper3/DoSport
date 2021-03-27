//
//  SportTypeGridViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

protocol SportTypeGridViewModelProtocol: class {
    var onDidLoadSportTypes: ((SportTypeGridViewModel.ViewState) -> Swift.Void)? { get set }
    var onDidSaveSportTypes: ((SportTypeGridViewModel.ViewState) -> Swift.Void)? { get set }
    var onDidSelectSportType: (() -> Swift.Void)? { get set }
    
    var sportTypes: Array<SportTypeGrid.SportType> { get }
    var selectedSportTypes: Array<SportTypeGrid.SportType> { get }
    
    func doLoadSportTypes()
    func doSaveSportTypes()
    func doSelect(_ sportType: SportTypeGrid.SportType)
}

final class SportTypeGridViewModel: SportTypeGridViewModelProtocol {
    
    enum ViewState {
        case loading
        case failed
        case success([SportTypeGrid.SportType]?)
    }
    
    var onDidLoadSportTypes: ((SportTypeGridViewModel.ViewState) -> Swift.Void)?
    var onDidSaveSportTypes: ((SportTypeGridViewModel.ViewState) -> Swift.Void)?
    var onDidSelectSportType: (() -> Swift.Void)?
    
    private let requestsManager: RequestsManager
    private var model: SportTypeGrid
    
    var sportTypes: Array<SportTypeGrid.SportType> {
        return model.sportTypes
    }
    
    var selectedSportTypes: Array<SportTypeGrid.SportType> {
        return model.selectedSportTypes
    }
    
    init(requestsManager: RequestsManager, model: SportTypeGrid) {
        self.requestsManager = requestsManager
        self.model = model
    }
    
    func doLoadSportTypes() {
        self.onDidLoadSportTypes?(.loading)
        
        requestsManager.sportTypesGet { [unowned self] response in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let result):
                
                switch result {
                case .object(let responseSportTypes):
                    let sportTypes = responseSportTypes.map {
                        responseSportType -> SportTypeGrid.SportType in
                        
                        return SportTypeGrid.SportType(
                            name: responseSportType.title ?? "",
                            isSelected: false,
                            id: responseSportType.id ?? 0
                        )
                    }
                    
                    self.model.sportTypes = sportTypes
                    self.onDidLoadSportTypes?(.success(model.sportTypes))
                    
                case .emptyObject:
                    print(#function, #file, #line, " need to finish handling empty object")
                }
            }
        }
    }
    
    func doSaveSportTypes() {
        self.onDidSaveSportTypes?(.loading)
        
        let requestSportTypes = self.selectedSportTypes.map {
            sportType -> DSModels.SportType.SportTypeView in
            
            return DSModels.SportType.SportTypeView(
                id: sportType.id,
                title: sportType.name
            )
        }
        
        requestsManager.userPreferredSportTypesEdit(params: requestSportTypes) { response in
            switch response {
            case .success:
                break
            case .failure:
                break
            }
        }
    }
    
    func doSelect(_ sportType: SportTypeGrid.SportType) {
        self.model.selectSportType(sportType)
        self.onDidSelectSportType?()
    }
}
