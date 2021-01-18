//
//  HomeView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    
}

final class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .red
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
