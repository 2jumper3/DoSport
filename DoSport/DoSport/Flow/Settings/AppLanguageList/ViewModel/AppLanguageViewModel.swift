//
//  AppLanguageViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/03/2021.
//

import Foundation

protocol AppLanguageViewModelProtocol: class {
    var onDidSelectLanaguage: ((AppLanguageViewModel.ViewState<[AppLanguageModel.Language]>) -> Swift.Void)? { get set }
    var choosenLanguageIndex: Int { get set }
    
    func chooseLanguage(_ language: AppLanguageModel.Language)
}

public final class AppLanguageViewModel: AppLanguageViewModelProtocol {

    public enum ViewState<T> {
        case loading
        case failed
        case success(T)
    }
    
    public var onDidSelectLanaguage: ((AppLanguageViewModel.ViewState<[AppLanguageModel.Language]>) -> Swift.Void)?
    
    private var model: AppLanguageModel = AppLanguageViewModel.createAppLanguageModel()
    
    init() {
        self.languages = model.languages
        self.choosenLanguageIndex = model.chosenLanguageIndex
    }
    
    static func createAppLanguageModel() -> AppLanguageModel {
        let languages: [AppLanguageModel.Language] = DSAppLanguage.Language.allCases.map {
            lang -> AppLanguageModel.Language in
            
            if lang.index == 0 {
                return .init(name: lang.title, isChoosen: true, id: lang.index)
            } else {
                return .init(name: lang.title, isChoosen: false, id: lang.index)
            }
        }
        
        return AppLanguageModel(languages: languages)
    }
    
    var choosenLanguageIndex: Int
    
    public var languages: [AppLanguageModel.Language] {
        didSet {
            onDidSelectLanaguage?(.success(self.languages))
        }
    }
    
    public func chooseLanguage(_ language: AppLanguageModel.Language) {
        self.onDidSelectLanaguage?(.loading)
        
        self.model.chooseLanguage(language) {
            self.languages = model.languages
            self.choosenLanguageIndex = model.chosenLanguageIndex
        }
    }
}
