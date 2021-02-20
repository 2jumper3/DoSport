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
        static var logo = image(named: "logo_image")
    }
    
    //MARK: - CountryList screen
    
    enum CountryList {
        static let backButton = image(named: "back_button")
    }
    
    //MARK: - OnboardingIcons screen
    
    enum OnboardingIcons {
        static var firstIcon: UIImage {
            return Icons.image(named: "firstPlayer")
        }
        static var secondIcon: UIImage {
            return Icons.image(named: "secondPlayer")
        }
        static var thirdIcon: UIImage {
            return Icons.image(named: "thirdPlayer")
        }
        static var fourthIcon: UIImage {
            return Icons.image(named: "fourPNG")
        }
    }
    
    //MARK: - Registration screen
    
    enum Registration {
        static var avatarDefault: UIImage {
            return Icons.image(named: "firstPlayer")
        }
    }
    
    //MARK: - PasswordEntry screen
    
    enum PasswordEntry {
        static var hiddenEye: UIImage {
            return Icons.image(named: "hidden_eye_icon")
        }
        
        static var showedEye: UIImage {
            return Icons.image(named: "showed_eye_icon")
        }
    }
    
    //MARK: - Feed screen
    
    enum Feed {
        static var plus: UIImage {
            return Icons.image(named: "plus")
        }
        
        static var options: UIImage {
            return Icons.image(named: "options")
        }
        
        static var subway: UIImage {
            return Icons.image(named: "subway")
        }
        
        static var location: UIImage {
            return Icons.image(named: "location")
        }
        
        static var currency: UIImage {
            return Icons.image(named: "currency")
        }
        
        static var defaultAvatar: UIImage {
            return Icons.image(named: "event_organiser_default_avatar")
        }
        
        static var clock: UIImage {
            return Icons.image(named: "clock")
        }
        
        static var chat: UIImage {
            return Icons.image(named: "chat")
        }
        
        static var user: UIImage {
            return Icons.image(named: "user")
        }
    }
    
    //MARK: - Event screen
    
    enum Event {
        static var messageSend: UIImage {
            return Icons.image(named: "message_send_button")
        }
        static let search: UIImage = Icons.image(named: "search")
        static let share: UIImage = Icons.image(named: "share")
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
}

extension Icons {
    
    enum Common {
        static let checkMark: UIImage = Icons.image(named: "check_mark")
        static let backButton = image(named: "back_button")
    }
    
    static func image(named name: String) -> UIImage {
        UIImage(named: name) ?? UIImage()
    }
}

