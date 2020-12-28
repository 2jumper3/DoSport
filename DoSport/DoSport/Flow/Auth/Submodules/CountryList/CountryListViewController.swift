//
//  CountryListViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import UIKit

final class CountryListViewController: UIViewController {
    
    var coordinator: CountryListCoordinator?
    
    override func loadView() {
        let view = CountryListView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Texts.CountryList.title
    }
}
