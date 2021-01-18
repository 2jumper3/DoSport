//
//  MapViewController.swift
//  DoSport
//
//  Created by Sergey on 28.12.2020.
//

import UIKit
import YandexMapsMobile
import CoreLocation

class MapViewController: UIViewController {
    // MARK: - Outlets
    var coordinator: MapCoordinator?
    let viewModel: MapViewModel
    
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
        addPlacemark()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPlacemark() {
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.clear()
        viewModel.loadCoordinates()
        guard let allPlacemarks = viewModel.coordinates else { return }
        for places in allPlacemarks {
            let point = YMKPoint(latitude: places.latitude, longitude: places.longitude)
            let placemark = mapObjects.addPlacemark(with: point)
            placemark.setIconWith(UIImage(named: "customPoint")!)
        }
    }
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        let targetLocation = YMKPoint(latitude: 55.847695, longitude: 37.361076)
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: targetLocation, zoom: 10, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
            cameraCallback: nil)
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

}
