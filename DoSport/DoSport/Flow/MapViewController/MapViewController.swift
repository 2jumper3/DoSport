//
//  MapViewController.swift
//  DoSport
//
//  Created by Sergey on 28.12.2020.
//

import UIKit
import YandexMapsMobile
import CoreLocation

protocol MapViewControllerDelegate {
    func createPopUpView(id: Int, name: String, range: Int, price: Int, location: String)
}

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
    var popUpView: PreviewLocationView = {
//        let view = PreviewLocationView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), id: 123, name: "123123", range: 123, price: 123, location: "Moscow")
        let view2 = PreviewLocationView()
        return view2
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
        self.view.addSubview(popUpView)
        mapView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.top.equalTo(view.snp.top).offset(53)
            make.right.equalTo(view.snp.right).offset(-16)
        }
        popUpView.snp.makeConstraints { (make) in
            make.top.equalTo(mapView.snp.bottom).offset(-88)
            make.left.equalTo(mapView.snp.left)
            make.right.equalTo(mapView.snp.right)
            make.height.equalTo(100)
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
        placemarkMapObjectTapListener.delegate = self
        placemarkMapObjectTapListener.child = popUpView
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
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
            self.popUpView.frame = self.popUpView.frame.offsetBy(dx: 0, dy: 100)
        }
        animator.startAnimation()
        return true
    }
    func onMapTap(with map: YMKMap, point: YMKPoint) {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
            self.popUpView.frame = self.popUpView.frame.offsetBy(dx: 0, dy: 100)
        }
        animator.startAnimation()
    }
    func onMapLongTap(with map: YMKMap, point: YMKPoint) {
        
    }
}

extension MapViewController: MapViewControllerDelegate {

    func createPopUpView(id: Int, name: String, range: Int, price: Int, location: String) {
        self.popUpView.textAdding(id: id, name: name, range: range, price: price, location: location) 
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
            self.popUpView.frame = self.popUpView.frame.offsetBy(dx: 0, dy: -100)
        }
        animator.startAnimation()
    }
}
