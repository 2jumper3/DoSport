//
//  DSRatingStackView.swift
//  DoSport
//
//  Created by Dmitrii Diadiushkin on 10.06.2021.
//

import UIKit

enum DSRatingStackViewState {
    case unrated, rated
}

protocol DSRatingStackViewDelegate: AnyObject {
    func ratingViewTapped()
}

final class DSRatingStackView: UIStackView {
    
    weak var delegate: DSRatingStackViewDelegate?
    
    private var stackViewState: DSRatingStackViewState = .unrated
    
    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        axis = .horizontal
        spacing = 20
        distribution = .equalCentering
        alignment = .center
        isUserInteractionEnabled = true
        
        addArrangedSubviews(makeRatingImageViews(imageCount: 5))
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DSRatingStackView {
    
    func bind(state: DSRatingStackViewState) {
        stackViewState = state
    }
    
    func getState() -> DSRatingStackViewState {
        return stackViewState
    }
}

private extension DSRatingStackView {
    
    func makeRatingImageViews(imageCount: Int) -> [UIImageView] {
        var imageViewStack: [UIImageView] = []
        for tag in 1...imageCount {
            let starImageView = UIImageView()
            starImageView.image = UIImage(named: "star")
            starImageView.frame.size.height = 20
            starImageView.frame.size.width = 20
            starImageView.tag = tag
            starImageView.isUserInteractionEnabled = true
            let starImageViewInteractionGesture = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped))
            starImageView.addGestureRecognizer(starImageViewInteractionGesture)
            imageViewStack.append(starImageView)
        }
        return imageViewStack
    }
    
    @objc func stackViewTapped(sender: UITapGestureRecognizer) {
        guard let tappedTag = sender.view?.tag else {return}
        userRated(tappedTag)
        if getState() == .unrated {
            self.bind(state: .rated)
            self.delegate?.ratingViewTapped()
        }
    }
    
    private func userRated(_ rating: Int) {
        for (index, item) in self.subviews.enumerated() {
            let imageView = item as! UIImageView
            if index < rating {
                imageView.image = UIImage(named: "star.filled")
            } else {
                imageView.image = UIImage(named: "star")
            }
        }
    }
}
