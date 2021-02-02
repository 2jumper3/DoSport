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
    private let transition = PanelTransition()
    var coordinator: MapCoordinator?
    let viewModel: MapViewModel
    private var placemarkMapObjectTapListener: PlacemarkMapObjectTapListener!

    
    private let mapView: YMKMapView = {
        let view = YMKMapView()
        return view
    }()
    private var button: FilterButton = {
        let btn = FilterButton(state: .notActivated)
        btn.addTarget(self, action: #selector(push), for: .touchUpInside)
        return btn
    }()
    private var button2: FilterButton = {
        let btn = FilterButton(state: .notActivated)
        btn.addTarget(self, action: #selector(push), for: .touchUpInside)
        return btn
    }()
    
    @objc func push()  {
        let child = PreviewLocation(id: 111, name: "Планетарная", range: 222, price: 333, location: "Площадь Ильича")
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        
        present(child, animated: true)
    }
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
        placemarkMapObjectTapListener = PlacemarkMapObjectTapListener(controller: self)
        viewModel.loadCoordinates()
        guard let allPlacemarks = viewModel.coordinates else { return }
        for places in allPlacemarks {
            let point = YMKPoint(latitude: places.latitude, longitude: places.longitude)
            let placemark = mapObjects.addPlacemark(with: point)
            placemark.userData = PlaceMarkUserData(id: places.id, name: places.name, range: places.range, price: places.price, location: places.location)
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
