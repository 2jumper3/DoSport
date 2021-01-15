//
//  RegistrationViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    var coordinator: RegistrationCoordinator?
    private let viewModel: RegistrationViewModel
    
    private lazy var registrationView = self.view as! RegistrationView
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Init
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func loadView() {
        let view = RegistrationView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Texts.Registration.navTitle
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
}

//MARK: - RegistrationViewDelegate

extension RegistrationViewController: RegistrationViewDelegate {
    func didTapSave() {
        viewModel.createUser()
    }
    
    func didTapMale() {
        print(#function)
    }
    
    func didTapFemale() {
        print(#function)
    }
}
