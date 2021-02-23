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

    enum FilterIcon {
        static var filter = image(named: "Filter")
    }
}

extension Icons {
    static func image(named name: String) -> UIImage {
        UIImage(named: name) ?? UIImage()
    }
}

extension Icons {
    enum MapIcons {
        static var placeMark = image(named: "customPoint")
        static var tappedPlaceMark = image(named: "tappedPoint")
    }
    enum PlacemarkTapped {
        static var price = image(named: "Rub")
        static var location = image(named: "Location")
        static var metro = image(named: "Metro")
    }
}
