//
//  Icons.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/12/2020.
//

import UIKit.UIImage

public enum Icons {
    
}

extension Icons {
    static func image(named name: String) -> UIImage {
        UIImage(named: name) ?? UIImage()
    }
}
