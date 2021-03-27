//
//  AppLanguage.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/03/2021.
//

import Foundation

/// This class describes some basic use cases of App language selection screen. Also provides Language model used in screen.
public class AppLanguageModel {
    
    public var languages: [Language]
    
    public struct Language: Identifiable {
        public let name: String
        public var isChoosen: Bool
        public let id: Int
    }
    
    init(languages: [Language]) {
        self.languages = languages
    }
    
    public var chosenLanguageIndex: Int = 0
    
    public func chooseLanguage(
        _ language: AppLanguageModel.Language,
        completion: () -> Swift.Void
    ) {
        if self.isChosenLanguageMatchesTo(new: language) {
            return
        } else {
            self.deselectPreviousChoice()
            
            guard let newChoosenIndex = self.index(of: language) else { return }
            self.chosenLanguageIndex = newChoosenIndex
            
            self.languages[chosenLanguageIndex].isChoosen = !self.languages[chosenLanguageIndex].isChoosen
            completion()
        }
    }
    
    private func isChosenLanguageMatchesTo(new language: Language) -> Bool {
        return language.id == self.languages[self.chosenLanguageIndex].id
    }
    
    private func index(of language: Language) -> Int? {
        for lang in self.languages {
            if lang.id == language.id {
                return lang.id
            }
        }
        
        return nil
    }
    
    private func deselectPreviousChoice() {
        self.languages[self.chosenLanguageIndex].isChoosen = !self.languages[self.chosenLanguageIndex].isChoosen
    }
}
