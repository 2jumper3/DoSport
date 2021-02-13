//
//  DateSelectionViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

final class DateSelectionViewController: UIViewController {
    
    var coordinator: DateSelectionCoordinator?
    private(set) var viewModel: DateSelectionViewModel
    
    private lazy var eventCreateView = view as! DateSelectionView
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Init
    
    init(viewModel: DateSelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        let view = DateSelectionView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Дата и время"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: - Private methods

private extension DateSelectionViewController {

}

//MARK: - Actions

@objc
private extension DateSelectionViewController {
    
    func handleCancelButton() {
        coordinator?.goBack()
    }
}
