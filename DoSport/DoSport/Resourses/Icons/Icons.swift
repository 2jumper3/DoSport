//
//  Icons.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/12/2020.
//

import UIKit.UIImage

public enum Icons {
    
    //MARK: - Auth screen
    
    enum Auth {
        static let logo: UIImage = image(named: "logo_image")
    }
    
    //MARK: - CountryList screen
    
    enum CountryList {
        static let backButton = image(named: "back_button")
    }
    
    //MARK: - OnboardingIcons screen
    
    enum OnboardingIcons {
        static let firstIcon: UIImage = Icons.image(named: "firstPlayer")
        static let secondIcon: UIImage = Icons.image(named: "secondPlayer")
        static let thirdIcon: UIImage = Icons.image(named: "thirdPlayer")
        static let fourthIcon: UIImage = Icons.image(named: "fourPNG")
    }
    
    //MARK: - Registration screen
    
    enum Registration {
        static var avatarDefault: UIImage {
            return Icons.image(named: "firstPlayer")
        }
    }
    
    //MARK: - PasswordEntry screen
    
    enum PasswordEntry {
        static let hiddenEye: UIImage = Icons.image(named: "hidden_eye_icon")
        static let showedEye: UIImage = Icons.image(named: "showed_eye_icon")
    }
    
    //MARK: - Feed screen
    
    enum Feed {
        static let plus: UIImage = Icons.image(named: "plus")
        static var options: UIImage = Icons.image(named: "options")
        static let subway: UIImage = Icons.image(named: "subway")
        static let location: UIImage = Icons.image(named: "location")
        static let currency: UIImage = Icons.image(named: "currency")
        static let defaultAvatar: UIImage = Common.defaultAvatar
        static let clock: UIImage = Icons.image(named: "clock")
        static let chat: UIImage = Icons.image(named: "chat")
        static let user: UIImage = Icons.image(named: "user")
    }
    
    //MARK: - Event screen
    
    enum Event {
        static let messageSend: UIImage = Icons.image(named: "message_send_button")
        static let search: UIImage = Icons.image(named: "search")
        static let share: UIImage = Icons.image(named: "share")
        static let defaultAvatar: UIImage = Common.defaultAvatar
    }
    
    //MARK: - EventCreate screen
    
    enum EventCreate {
        static let cancel: UIImage = Icons.image(named: "cancel")
        static let closed: UIImage = Icons.image(named: "closed")
        static let next: UIImage = Icons.image(named: "next")
        static let checkMark: UIImage = Icons.image(named: "check_mark")
        static let sliderThumb: UIImage = Icons.image(named: "sliderThumb")
    }
    
    //MARK: - SportGroundSelectionList screen
    
    enum SportGroundSelectionList {
        static let filter = Icons.image(named: "filter")
        static let map = Icons.image(named: "map")
    }
    
    //MARK: - SportTypeList screen
    
    enum SportTypeList {
        static let checkMark = Common.checkMark
        static let backButton = Common.backButton
    }
    
    //MARK: - UserMain screen
    
    enum UserMain {
        static let settings = Icons.image(named: "settings")
    }
}

extension Icons {
    
    enum Common {
        static let checkMark: UIImage = Icons.image(named: "check_mark")
        static let backButton = image(named: "back_button")
        static let defaultAvatar: UIImage = Icons.image(named: "default_avatar")
    }
    
    static func image(named name: String) -> UIImage {
        UIImage(named: name) ?? UIImage()
    }
}
