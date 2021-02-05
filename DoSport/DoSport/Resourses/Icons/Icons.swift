//
//  Icons.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/12/2020.
//

import UIKit.UIImage

public enum Icons {
    enum Auth {
        static var logo = image(named: "logo_image")
    }
    
    enum CountryList {
        static let backButton = image(named: "back_button")
    }
    
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
    
    enum Registration {
        static var avatarDefault: UIImage {
            return Icons.image(named: "firstPlayer")
        }
    }
    
    enum PasswordEntry {
        static var hiddenEye: UIImage {
            return Icons.image(named: "hidden_eye_icon")
        }
        
        static var showedEye: UIImage {
            return Icons.image(named: "showed_eye_icon")
        }
    }
    
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
}

extension Icons {
    static func image(named name: String) -> UIImage {
        UIImage(named: name) ?? UIImage()
    }
}
