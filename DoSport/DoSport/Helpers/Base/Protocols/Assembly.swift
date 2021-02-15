//
//  Assembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

protocol Assembly {
    associatedtype ViewController: UIViewController
    
    func makeModule() -> ViewController
}

