//
//  FeedBackViewController.swift
//  DoSport
//
//  Created by Dmitrii Diadiushkin on 31.05.2021.
//

import UIKit

final class FeedBackViewController: UIViewController {

    weak var coordinator: FeedBackCoordinator?
    private lazy var feedBackView = view as! FeedbackView
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = FeedbackView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }

}

//MARK: - Private API

private extension FeedBackViewController {
    func setupNavBar() {
        title = Texts.FeedBack.navTitle
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: Fonts.sfProRegular(size: 18),
            NSAttributedString.Key.foregroundColor: Colors.mainBlue
        ]
        
        navigationItem.setHidesBackButton(true, animated: true)
        let button = UIButton(type: .system)
        button.setImage(Icons.EventCreate.cancel, for: .normal)
        button.tintColor = Colors.mainBlue
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
}

//MARK: Actions

@objc private extension FeedBackViewController {
    
    func handleCancelButton() {
        coordinator?.goBack()
    }
}
