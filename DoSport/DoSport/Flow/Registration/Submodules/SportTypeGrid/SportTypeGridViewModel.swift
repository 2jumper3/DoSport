//
//  SportTypeGridViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

protocol SportTypeGridViewModel: class {
    func doLoadSportTypes(request: SportTypeGridDataFlow.LoadSportTypes.Request)
    func doSaveSportTypes(request: SportTypeGridDataFlow.SaveSelectedSportTypes.Request)
}

final class SportTypeGridViewModelImplementation: NSObject, SportTypeGridViewModel {
    
    weak var viewController: SportTypeGridViewControllerProtocol?
    
    private let requestManager: RequestsManager
    
    init(requestManager: RequestsManager) {
        self.requestManager = requestManager
        super.init()
    }
    
    func doLoadSportTypes(request: SportTypeGridDataFlow.LoadSportTypes.Request) {
        self.viewController?.displaySportTypes(viewModel: .init(state: .loading))
        
        self.requestManager.sportTypesGet { [weak self] response in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                
                switch result {
                case .object(let sportTypes):
                    self?.viewController?.displaySportTypes(viewModel: .init(state: .success(sportTypes)))
                case .emptyObject:
                    print(#function, #file, #line, " need to finish handling empty object")
                }
            }
        }
    }
    
    func doSaveSportTypes(request: SportTypeGridDataFlow.SaveSelectedSportTypes.Request) {
        self.viewController?.displaySaveSportTypesResult(viewModel: .init(state: .loading))
        
        requestManager.userPreferredSportTypesEdit(params: request.sportTypes) { response in
            switch response {
            case .success:
                self.viewController?.displaySaveSportTypesResult(viewModel: .init(state: .success(nil)))
            case .failure:
                DispatchQueue.main.async {
                    self.viewController?.displaySaveSportTypesResult(viewModel: .init(state: .success(nil)))
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
