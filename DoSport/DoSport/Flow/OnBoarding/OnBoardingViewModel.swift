//
//  OnBoardingViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/03/2021.
//

import Foundation

protocol OnBoardingViewModelProtocol: class {
    func goToSignUpModuleRequest()
}

final class OnBoardingViewModel: OnBoardingViewModelProtocol {
    
    private weak var coordinator: OnBoardingCoordinator?
    
    init(coordinator: OnBoardingCoordinator) {
        self.coordinator = coordinator
    }
    
    func goToSignUpModuleRequest() {
        self.coordinator?.goToAuthView()
    }
}
