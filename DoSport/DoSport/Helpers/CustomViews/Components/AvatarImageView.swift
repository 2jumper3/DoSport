//
//  AvatarImageView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 16/01/2021.
//

import UIKit.UIImageView

final class AvatartImageView: UIImageView {
    
    init(image: UIImage) {
        super.init(frame: .zero)
        layer.borderColor = Colors.dirtyBlue.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        clipsToBounds = true
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }   
}
