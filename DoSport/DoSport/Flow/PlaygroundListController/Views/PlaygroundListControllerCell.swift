//
//  HomePageCollectionViewCell.swift
//  YoutubeMenuBar
//
//  Created by Manikanta Varma on 5/20/18.
//  Copyright © 2018 Manikanta Varma. All rights reserved.
//

import UIKit

class PlaygroundListControllerCell: UICollectionViewCell {

    static let reuseId = "TypeSportPlacesControllerCell"
    var controller: PlaygroundController = {
        let controller = PlaygroundController()
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
