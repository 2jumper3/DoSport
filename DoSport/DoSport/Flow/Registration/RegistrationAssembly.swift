//
//  RegistrationAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit

final class RegistrationAssembly: Assembly {
    func makeModule() -> RegistrationViewController {
        let viewModel = RegistrationViewModel()
        let vc = RegistrationViewController(viewModel: viewModel)
        return vc
    }
}
