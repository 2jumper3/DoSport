//
//  SportTypeGridViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

protocol SportTypeGridViewModel: class {
    var onDidLoadSportTypes: ((SportTypeGridDataFlow.LoadSportTypes.ViewModel) -> Swift.Void)? { get set }
    var onDidSaveSportTypes: ((SportTypeGridDataFlow.SaveSelectedSportTypes.ViewModel) -> Swift.Void)? { get set } 
    
    func doLoadSportTypes(request: SportTypeGridDataFlow.LoadSportTypes.Request)
    func doSaveSportTypes(request: SportTypeGridDataFlow.SaveSelectedSportTypes.Request)
}

final class SportTypeGridViewModelImplementation: NSObject, SportTypeGridViewModel {
    
    var onDidLoadSportTypes: ((SportTypeGridDataFlow.LoadSportTypes.ViewModel) -> Swift.Void)?
    var onDidSaveSportTypes: ((SportTypeGridDataFlow.SaveSelectedSportTypes.ViewModel) -> Swift.Void)?
    
    private let requestManager: RequestsManager
    
    init(requestManager: RequestsManager) {
        self.requestManager = requestManager
        super.init()
    }
    
    func doLoadSportTypes(request: SportTypeGridDataFlow.LoadSportTypes.Request) {
        self.onDidLoadSportTypes?(.init(state: .loading))
        
        self.requestManager.sportTypesGet { [weak self] response in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                
                switch result {
                case .object(let sportTypes):
                    self?.onDidLoadSportTypes?(.init(state: .success(sportTypes)))
                case .emptyObject:
                    print(#function, #file, #line, " need to finish handling empty object")
                }
            }
        }
    }
    
    func doSaveSportTypes(request: SportTypeGridDataFlow.SaveSelectedSportTypes.Request) {
        self.onDidSaveSportTypes?(.init(state: .loading))
        
        requestManager.userPreferredSportTypesEdit(params: request.sportTypes) { response in
            switch response {
            case .success:
                self.onDidSaveSportTypes?(.init(state: .success(nil)))
            case .failure:
                DispatchQueue.main.async {
                    self.onDidSaveSportTypes?(.init(state: .success(nil)))
                }
            }
        }
    }
}

//MARK: - DataFow -

enum SportTypeGridDataFlow {
    enum LoadSportTypes {
        struct Request { }
        
        struct ViewModel {
            let state: ViewControllerState
        }
    }
    
    enum SaveSelectedSportTypes {
        struct Request {
            let sportTypes: [DSModels.SportType.SportTypeView]
        }
        
        struct ViewModel {
            let state: ViewControllerState
        }
    }
    
    enum ViewControllerState {
        case loading
        case failed
        case success([DSModels.SportType.SportTypeView]?)
    }
}
