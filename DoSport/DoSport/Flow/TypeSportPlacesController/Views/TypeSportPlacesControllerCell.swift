//
//  HomePageCollectionViewCell.swift
//  YoutubeMenuBar
//
//  Created by Manikanta Varma on 5/20/18.
//  Copyright © 2018 Manikanta Varma. All rights reserved.
//

import UIKit

class TypeSportPlacesControllerCell: UICollectionViewCell {

    static let reuseId = "TypeSportPlacesControllerCell"
    let controller: SportGroundController = {
        let controller = SportGroundController()
        return controller
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(controller.view)
        controller.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
