//
//  SoundListController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

final class SoundListController: UIViewController, UIGestureRecognizerDelegate {
    
    weak var coordinator: SoundListCoordinator?
    private lazy var soundListView = view as! SoundListView
    private let soundListDataSource = SoundListDataSource()
    
    private let compilation: (String) -> Swift.Void
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(compilation: @escaping (String) -> Swift.Void) {
        self.compilation = compilation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = SoundListView()
        view.delegate = self
        soundListDataSource.delegate = self
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        soundListView.updateCollectionDataSource(dateSource: soundListDataSource)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: Private API

private extension SoundListController {
    
    func setupNavBar() {
        title = Texts.SoundList.title
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let backBarButton = UIButton.makeBarButton()
        backBarButton.addTarget(self, action: #selector(handleGoBackButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)
    }
}

//MARK: Actions

@objc private extension SoundListController {
    
    func handleGoBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - SoundListViewDelegate -

extension SoundListController: SoundListViewDelegate { }

//MARK: - SoundListDataSourceDelegate -

extension SoundListController: SoundListDataSourceDelegate {
    
    func tableView(didSelect sound: String) {
        compilation(sound)
    }
}
