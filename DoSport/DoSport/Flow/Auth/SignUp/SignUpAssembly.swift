//
//  SignUpAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit

final class SignUpAssembly: Assembly {
    
    func makeModule() -> SignUpViewController {
        let viewModel = SignUpViewModel()
        let vc = SignUpViewController(viewModel: viewModel)
        return vc
    }
}
