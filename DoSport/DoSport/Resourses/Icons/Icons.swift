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
}

extension Icons {
    static func image(named name: String) -> UIImage {
        UIImage(named: name) ?? UIImage()
    }
}
