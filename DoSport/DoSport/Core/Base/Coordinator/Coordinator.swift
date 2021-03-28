//
//  Coordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

protocol Coordinator: class {
    
    var navigationController: UINavigationController? { get set }
    
    func start()
}
