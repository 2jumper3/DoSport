//
//  AuthAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

final class AuthAssembly: Assembly {
    
    func makeModule() -> PhoneAddViewController {
        let viewModel = PhoneAddViewModel()
        let viewController = PhoneAddViewController(viewModel: viewModel)
        return viewController
    }
}
