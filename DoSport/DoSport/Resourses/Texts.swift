//
//  Texts.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/12/2020.
//

import Foundation

public enum Texts { }

//MARK: - OnBoarding Screen
extension Texts {
    enum OnBoardingText {
        enum headers {
            static var firstSlideText: String {
                return "Найди команду"
            }
            static var secondSlideText: String {
                return "Создавай встречи"
            }
            static var thirdSlideText: String {
                return "Бронируй площадки"
            }
            static var fourthSlideText: String {
                return "Общайся"
            }
        }
        
        enum Description {
            static var firstSlideText: String {
                return "Любишь футбол, баскетбол и волейбол, но все друзья отказываются покидать уютные диваны? Устал давать пасы сам себе на безлюдной площадке? Собери свою команду и присоединись к игре!"
            }
            static var secondSlideText: String {
                return "Тренируйтесь или участвуйте в соревнованиях с другими командами"
            }
            static var thirdSlideText: String {
                return "Выбирай места для тренировок прямо через приложение"
            }
            static var fourthSlideText: String {
                return "Находи единомышленников, создавай чаты, планируй тренировки! "
            }
        }
    }
}


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

//MARK: - CountryList Screen
extension Texts {
    enum CountryList {
        static let title = "Регион"
        static let search = "Поиск"
        static let noResults = "По вашему запросу ничего не найдено"
    }
}

//MARK: - CodeEntry Screen
extension Texts {
    enum CodeEntry {
        static let title = "Вход"
        static let confirmation = "Код подтверждения, который мы прислали"
        static let codeSentToNumber = "Код был отправлен на номер"
        static let codeResend = "Повторно отправить SMS"
    }
}
