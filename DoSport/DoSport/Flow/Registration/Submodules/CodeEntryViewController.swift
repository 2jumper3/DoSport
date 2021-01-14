//
//  CodeEntryViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/01/2021.
//

import UIKit

final class CodeEntryViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var coordinator: CodeEntryCoordinator?
    private let viewModel: CodeEntryViewModel
    
    private lazy var codeEntryView = self.view as! CodeEntryView
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Life cycle
    
    init(viewModel: CodeEntryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = CodeEntryView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        navigationController?.interactivePopGestureRecognizer?.delegate = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        codeEntryView.bind()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        codeEntryView.endEditing(true)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: - CodeEntryViewDelegate

extension CodeEntryViewController: CodeEntryViewDelegate {
    func didTapCodeResentButton() {
        print(#function)
    }
    
    func didTapGoBackButton() {
        coordinator?.goBack()
    }
}
