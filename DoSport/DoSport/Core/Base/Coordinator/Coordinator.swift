//
//  Coordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

protocol Coordinator: AnyObject {
    
    /// Used to add strong reference to appended Coordingator object in order to avoid memory issues
    var childCoordinators: [Coordinator] { get set }
    
    var navigationController: UINavigationController? { get set }
    
    /// Shows `rootViewController`  with animation by `push` method.
    func start()
    
    // extension implemented
    func removeDependency(_ coordinator: Coordinator?)
    func store(coordinator: Coordinator)
}

extension Coordinator {
    
    /// Removes strong reference of removed Coordingator object in order to avoid memory issues
    /// - Parameters:
    ///     - coordinator: coordinator object that is removed from array
    func removeDependency(_ coordinator: Coordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
        else { return }

        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    /// Adds strong reference for appended Coordingator object in order to avoid memory issues
    /// - Parameters:
    ///     - coordinator: coordinator object that is added into array
    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
}
