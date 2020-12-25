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
}

extension Icons {
    static func image(named name: String) -> UIImage {
        UIImage(named: name) ?? UIImage()
    }
}
