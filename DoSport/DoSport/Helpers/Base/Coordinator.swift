//
//  Coordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    
    func start()
    
    // extension implemented
//    func removeDependency(_ coordinator: Coordinator?)
//    func store(coordinator: Coordinator)
}

//extension Coordinator {
//    func removeDependency(_ coordinator: Coordinator?) {
//        guard
//            childCoordinators.isEmpty == false,
//            let coordinator = coordinator
//        else { return }
//
//        for (index, element) in childCoordinators.enumerated() where element === coordinator {
//            childCoordinators.remove(at: index)
//            break
//        }
//    }
//
//    func store(coordinator: Coordinator) {
//        childCoordinators.append(coordinator)
//    }
//}
