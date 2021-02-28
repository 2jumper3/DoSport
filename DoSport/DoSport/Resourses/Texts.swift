//
//  Texts.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/12/2020.
//

import Foundation

public enum Texts {
    enum Common {
        static let save = "Сохранить"
        static let date = "Дата и время"
        static let invite = "Пригласить"
    }
}

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
//MARK: - Registration Screen
extension Texts {
    enum Registration {
        static let navTitle = "Регистрация"
        
        static let addAvatar = "Загузить фото"
        static let save = Common.save
        
        static let userName = "Никнейм"
        static let userNameError = "Никнейм занят"
        
        static let password = "Пароль"
        static let passwordError = "Неверный формат пароля"
        
        static let dob = "Дата рождения"
        static let dobError = "Неверный формат Даты рождения"
        
        enum Gender {
            static let male = "Мужчина"
            static let female = "Женщина"
        }
    }
}

//MARK: - SportTypeGrid Screen
extension Texts {
    enum SportTypeGrid {
        static let title = "Что тебе интересно?"
        static let save = Common.save
    }
}

//MARK: - PasswordEntry Screen
extension Texts {
    enum PasswordEntry {
        static let title = "Вход"
        static let forgotPassword = "Забыли пароль?"
        static let enter = "Войти"
    }
}

//MARK: - Feed screen
extension Texts {
    enum Feed {
        static let title = "Создать тренировку"
        static let feedTitle = "Лента"
        
        static let all = "Все"
        static let subscribes = "Подписки"
        static let subscribers = "Подписчики"
        
        static let free = "Бесплатно"
        static let km3 = "3 км"
        
        static let cancel = "Отменить"
        static let invite = Common.invite
        static let selectChat = "Выберите чаты"
    }
}

//MARK: - Event screen
extension Texts {
    enum Event {
        static let invite = Common.invite
        static let participate = "Участвовать"
        static let participating = "Ты в игре!"
        
        static let reply = "Ответить"
        
        static let messages = "Написать сообщение..."
    }
}

//MARK: - EventCreate screen
extension Texts {
    enum EventCreate {
        static let navTitle = "Создать тренировку"
        
        static let create = "Создать"
        static let closed = "Закрытая"
        static let closedEventInfo = "В закрытую тренировку только вы можете пригласить участников"
        static let sportTypes = "Вид спорта"
        static let playground = "Площадка"
        static let date = Common.date
        static let memberCount = "Количество участников"
        static let noLimit = "Без ограничений"
        static let placeholder = "Расскажите о тренировке..."
    }
}

//MARK: - SportTypeList screen
extension Texts {
    enum SportTypeList {
        static let navTitle = "Выбрать вид спорта"
        static let select = "Выбрать"
    }
}

//MARK: - DateSelection screen
extension Texts {
    enum DateSelection {
        static let save = Common.save
        static let date = Common.date
    }
}

//MARK: - SportGroundSelectionList screen
extension Texts {
    enum SportGroundSelectionList {
        static let select = "Выбрать"
    }
}
//MARK: - MapFilter screen


extension Texts {
    enum PlaceTypeTableViewCell {
        static let ground = "Площадки"
        static let training = "Тренировки"
        static let studio = "Студии"
        static let clubs = "Тренажерные залы"
        static let challenges = "Соревнования"
        static let group = "Групповые тренировки"
    }
}
