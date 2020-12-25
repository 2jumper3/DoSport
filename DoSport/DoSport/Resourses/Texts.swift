//
//  Texts.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/12/2020.
//

import Foundation

public enum Texts { }

//MARK: - Auth Screen
extension Texts {
    enum Auth {
        static let submit = "Отправить SMS"
        static let phoneNumberPlaceholder = "Номер телефона"
        static let enter = "Вход"
        static let description = "Ваш номер телефона будет использоваться для входа в приложение"
        enum Regulations {
            static let upper = "Нажимая «Отправить SMS», ты принимаешь "
            static let bottom = "Правила пользования и Защиты информации"
        }
    }
}
