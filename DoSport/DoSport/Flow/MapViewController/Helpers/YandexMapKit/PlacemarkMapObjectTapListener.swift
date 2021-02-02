//
//  PlacemarkMapObjectTapListener.swift
//  DoSport
//
//  Created by Sergey on 29.01.2021.
//

import UIKit
import YandexMapsMobile

// MARK: - Pop-up panel settings
 class PlacemarkMapObjectTapListener: NSObject, YMKMapObjectTapListener {
    private let transition = PanelTransition()
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        if let object = mapObject as? YMKPlacemarkMapObject {
            object.setIconWith(Icons.MapIcons.tappedPlaceMark)
        if let userData = object.userData as? PlaceMarkUserData {
            let child = PreviewLocation(id: Int(userData.id), name: userData.name, range: userData.range, price: userData.price, location: userData.location)
            child.transitioningDelegate = transition
            child.modalPresentationStyle = .custom
            controller?.present(child, animated: true)
            }
        }
        return true;
    }
    
    private weak var controller: UIViewController?
    init(controller: UIViewController) {
        self.controller = controller
    }
}

 class PlaceMarkUserData {
    let id: Int;
    let name: String;
    let range: Int;
    let price: Int;
    let location: String;
    init(id: Int, name: String, range: Int, price: Int, location: String) {
        self.id = id;
        self.name = name;
        self.range = range;
        self.price = price;
        self.location = location;
    }
}
