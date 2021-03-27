//
//  MainViewController.swift
//  DoSport
//
//  Created by Sergey on 24.12.2020.
//

import UIKit

final class MainSportTypeSelectionController: UIViewController {
    
    weak var coordinator: MainSportTypeSelectionCoordinator?
    private let viewModel: MainSportTypeSelectionViewModel
    private let collectionManager: MainSportTypeSelectionDataSource = MainSportTypeSelectionDataSource()
    private lazy var mainSportTypeSelectionView = self.view as! MainSportTypeSelectionView
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    //MARK: Init
    
    init(viewModel: MainSportTypeSelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func loadView() {
        let view = MainSportTypeSelectionView()
        view.delegateSeachBar(to: self)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        
        setupViewModelBindings()
        viewModel.prepareSportTypeModels()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        mainSportTypeSelectionView.bindSearchBarToDefaultStyle()
    }
}

//MARK: Private API

private extension MainSportTypeSelectionController {
    
    func setupViewModelBindings() {
        viewModel.onMainSportTypeModelsReady = { [weak self] sportTypes in
            guard let self = self else { return }
            
            self.collectionManager.viewModels = sportTypes
            self.mainSportTypeSelectionView.updateCollectionDataSource(dateSource: self.collectionManager)
        }
    }
}

//MARK: - UITextFieldDelegate -

extension MainSportTypeSelectionController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        mainSportTypeSelectionView.bindSearchBarToColorizedStyle()
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text else { return false }
        
        viewModel.searchSportType(by: text, string: string)
        
        return true
    }
}
