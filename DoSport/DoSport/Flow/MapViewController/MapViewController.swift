//
//  MapViewController.swift
//  DoSport
//
//  Created by Sergey on 28.12.2020.
//

import UIKit
import YandexMapsMobile
import CoreLocation

class MapViewController: UIViewController, YMKLayersGeoObjectTapListener, YMKMapInputListener {

    
    // MARK: - Outlets
    let cardTransitioningDelegate = CardTransitioningDelegate()
    var coordinator: MapCoordinator?
    let viewModel: MapViewModel
    private var placemarkMapObjectTapListener: PlacemarkMapObjectTapListener!

    
    private let mapView: YMKMapView = {
        let view = YMKMapView()
        return view
    }()
    private var button: FilterButton = {
        return FilterButton(state: .notActivated)
    }()
    

    private let locationManager = CLLocationManager()
    // MARK: - Init
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        mapSetup()
    }
    override func viewWillLayoutSubviews() {
        navigationController?.navigationBar.isHidden = true
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.top.equalTo(view.snp.top).offset(53)
            make.right.equalTo(view.snp.right).offset(-16)
            
        }
    }
    // MARK: - Map Settings
    
    private class PlacemarkMapObjectTapListener: NSObject, YMKMapObjectTapListener {
        
        func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
            if let object = mapObject as? YMKPlacemarkMapObject {
//                object.setIconWith(Icons.MapIcons.tappedPlaceMark)
//            }
            if let userData = object.userData as? PlaceMarkUserData {
                let message = "Circle with \(userData.location) and description userData. tapped";
                let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert);
                alert.view.backgroundColor = UIColor.darkGray;
                alert.view.alpha = 0.8;
                alert.view.layer.cornerRadius = 15;

//                controller?.present(alert, animated: true);
                
                controller?.present(view, animated: true, completion: nil)
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    let view = PreviewLocation(frame: .zero, id: 12, name: "name", range: 12, price: 12, location: "location")
                    view.transitioningDelegate = cardTransitioningDelegate
                    view.modalPresentationStyle = .custom
                }
            }
            }
            return true;
        }
        
        private weak var controller: UIViewController?
            
        init(controller: UIViewController) {
            self.controller = controller
        }
    }
    
    private class PlaceMarkUserData {
        let id: Int32;
        let name: String;
        let range: Int;
        let price: Int;
        let location: String;
        init(id: Int32, name: String, range: Int, price: Int, location: String) {
            self.id = id;
            self.name = name;
            self.range = range;
            self.price = price;
            self.location = location;
        }
    }
    
    private func mapSetup() {
        let targetLocation = YMKPoint(latitude: 55.847695, longitude: 37.361076)
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: targetLocation, zoom: 15, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
            cameraCallback: nil)
        mapView.mapWindow.map.addTapListener(with: self)
        mapView.mapWindow.map.addInputListener(with: self)
        
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.clear()
        viewModel.loadCoordinates()
        guard let allPlacemarks = viewModel.coordinates else { return }
        for places in allPlacemarks {
            let point = YMKPoint(latitude: places.latitude, longitude: places.longitude)
            let placemark = mapObjects.addPlacemark(with: point)
            placemark.userData = PlaceMarkUserData(id: 32, name: "123", range: 32, price: 32, location: "321")
            placemarkMapObjectTapListener = PlacemarkMapObjectTapListener(controller: self);
            placemark.addTapListener(with: placemarkMapObjectTapListener)
            placemark.setIconWith(Icons.MapIcons.placeMark)
        }
    }
    
    func onObjectTap(with: YMKGeoObjectTapEvent) -> Bool {
        print("tapped from xz")
        return true
    }
    func onMapTap(with map: YMKMap, point: YMKPoint) {
//        mapView.mapWindow.map.mapObjects.
    }
    func onMapLongTap(with map: YMKMap, point: YMKPoint) {
        
    }

}
