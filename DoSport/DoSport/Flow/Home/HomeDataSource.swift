//
//  HomeDataSource.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class HomeDataSource: NSObject {
    
    var viewModels: [Event]
    
    init(viewModels: [Event] = []) {
        self.viewModels = viewModels
        super.init()
    }
}
