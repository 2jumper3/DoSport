//
//  PasswordEntryViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class PasswordEntryViewController: UIViewController {
    
    var coordinator: PasswordEntryCoordinator?
    private let viewModel: PasswordEntryViewModel
    
    private lazy var passwordEntryView = self.view as! PasswordEntryView
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Init
    
    init(viewModel: PasswordEntryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func loadView() {
        let view = PasswordEntryView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordEntryView.endEditing(true)
    }
}

//MARK: - PasswordEntryViewDelegate

extension PasswordEntryViewController: PasswordEntryViewDelegate {
    
}
