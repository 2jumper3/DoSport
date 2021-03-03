//
//  UIImage+toString.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 02/03/2021.
//

import UIKit.UIImage

extension UIImage {
    
    // https://stackoverflow.com/questions/50085231/uiimage-to-string-and-string-to-uiimage-in-swift
    func toString() -> String? {
        let data: Data? = self.jpegData(compressionQuality: 0.5)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}


