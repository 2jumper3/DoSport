//
//  DSAppLanguage.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import Foundation

struct DSAppLanguage {
    
    enum Language: String, CaseIterable {
        case rus, eng, arab, belarus, french, german, indo, italian, kor, pol, portu, turk, ukr, uzb
        
        var title: String {
            switch self {
            case .rus: return "Русский"
            case .eng: return "Английский"
            case .arab: return "Арабский"
            case .belarus: return "Беларуссикий"
            case .french: return "Французский"
            case .german: return "Немецкий"
            case .indo: return "Индийский"
            case .italian: return "Итальянский"
            case .kor: return "Корейский"
            case .pol: return "Польский"
            case .portu: return "Португальский"
            case .turk: return "Турецский"
            case .ukr: return "Украинский"
            case .uzb: return "Узбекский"
            }
        }
    }
}
