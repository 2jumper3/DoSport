//
//  AppLanguageListCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

/// Describes navigation & coordination of class that controlls App Language selection screen.
final class AppLanguageListCoordinator: Coordinator {
    
    /// Object that controlls the view events in App Language selection screen.
    let rootViewController: AppLanguageListController
    
    ///
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    /// Initialises an AppLanguageListCoordinator object.
    ///
    /// - Parameters:
    ///     - navController: navigation controller provided from previous coordinator used to `push` App Language selection screen controller.
    ///     - compilation: is called when user select app language in App Language selection screen
    ///     - language: the `String` name of app language that user selects
    init(navController: UINavigationController?, compilation: @escaping (_ language: String) -> Swift.Void) {
        self.rootViewController = AppLanguageListController(compilation: compilation)
        self.navigationController = navController
    }
    
    /// Shows `rootViewController`  with animation by `push` method.
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
