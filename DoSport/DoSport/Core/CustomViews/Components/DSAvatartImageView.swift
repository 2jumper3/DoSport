//
//  DSAvatartImageView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 16/01/2021.
//

import UIKit

/// This class describes view object that has UIImageView inside.
///
/// Basically it  provides space between rounded border and UIImage, adding UIImageView as subview and making its frame smaller that parentView's.
final class DSAvatartImageView: UIView {
    
    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }
    
    private let imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView ())
    
    init(
        image: UIImage = Icons.Common.defaultAvatar,
        borderColor bColor: UIColor = Colors.dirtyBlue
    ) {
        super.init(frame: .zero)
        self.imageView.image = image
        layer.borderColor = bColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        clipsToBounds = true
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        imageView.snp.makeConstraints { $0.edges.equalToSuperview().inset(15) }
    }
}
