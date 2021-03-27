//
//  SignUpAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit

final class SignUpAssembly: Assembly {
    
    func makeModule() -> SignUpViewController {
        let requestsManager = RequestsManager.shared
        let viewModel = SignUpViewModel(requestsManager: requestsManager)
        let vc = SignUpViewController(viewModel: viewModel)
        return vc
    }
}
