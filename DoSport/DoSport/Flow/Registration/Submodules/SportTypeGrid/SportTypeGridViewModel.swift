//
//  SportTypeGridViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

final class SportTypeGridViewModel {
    
    var onDataDidPrepare: (([DSModels.Api.SportType.SportTypeResponse]) -> Void)?
    private let requestManager: RequestsManager
    
    private var sports: [DSModels.Api.SportType.SportTypeResponse] = [] {
        didSet {
            onDataDidPrepare?(sports)
        }
    }
    
    private var selectedSports: [DSModels.Api.SportType.SportTypeResponse] = []
    
    init(requestManager: RequestsManager) {
        self.requestManager = requestManager
    }
    
    func prepareData() {
        self.requestManager.sportTypesGet(params: .init()) { [weak self] sportTypesResult in
            switch sportTypesResult{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let sportTypes):
                
                self?.sports = sportTypes.compactMap({ sportType -> DSModels.Api.SportType.SportTypeResponse? in
                    return sportType
                })
            }
        }
    }
    
    func handleDataSelection(_ sport: DSModels.Api.SportType.SportTypeResponse) {
        guard selectedSports.count > 0 else {
            selectedSports.append(sport)
            return
        }
        
        for (i, existedSport) in selectedSports.enumerated() {
            if existedSport == sport {
                selectedSports.remove(at: i)
            } else {
                selectedSports.append(sport)
            }
            return
        }
    }
    
    func saveData(compilation: () -> Void) {
//        requestManager.sportTypeGetById(params: .init(id: 4)) { result in
//            switch result{
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let result):
//                print(result)
//            }
//        }
        
        requestManager.sportTypePut(
            params: .init(
                sportTypeID: 34,
                title: "%7B%22sportTitle%22%3A%22Box%22%7D="
            )
        ) { result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let result):
                print(result)
            }
        }
        
//        requestManager.sportTypeCreate(params: .init(sportTitle: "KickBoxing")) { result in
//            switch result{
//            case .failure(let error):
//                print(error)
//            case .success(let result):
//                print(result)
//            }
//        }
        
//        requestManager.sportTypeDelete(params: .init(id: 34)) { result in
//            switch result{
//            case .failure(let error):
//                print(error)
//            case .success(let models):
//                print(models)
//
//            }
//        }
        compilation()
    }
}
