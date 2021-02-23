//
//  CountryListCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import UIKit

final class CountryListCoordinator: Coordinator { //Todo: remove coordinator from CountryList module.
    
    let rootViewController: CountryListViewController
    
    var compilation: ((String) -> Swift.Void)?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?, compilation: ((String) -> Swift.Void)?) {
        let assembly = CountryListAssembly()
        self.navigationController = navController
        self.rootViewController = assembly.makeModule()
        self.compilation = compilation
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func goBack(with country: Country) {
        guard let callingCode = country.callingCode else { return }
        compilation?(callingCode)
        navigationController?.popViewController(animated: true)
    }
}
