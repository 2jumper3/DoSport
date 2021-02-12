//
//  SportTypeListViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

final class SportTypeListViewController: UIViewController {
    
    var coordinator: SportTypeListCoordinator?
    private(set) var viewModel: SportTypeListViewModel
    
    private lazy var eventCreateView = view as! SportTypeListView
    
    var cell: UITableViewCell?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Init
    
    init(viewModel: SportTypeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        let view = SportTypeListView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Виды спорта"
        
        if let cell = cell as? SelectionCell {
            cell.bind("Football")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: - Private methods

private extension SportTypeListViewController {

}

//MARK: - Actions

@objc
private extension SportTypeListViewController {
    
    func handleCancelButton() {
        coordinator?.goBack()
    }
}


