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
    private let mapView: YMKMapView = {
        let view = YMKMapView()
        return view
    }()
    private var button: FilterButton = {
        return FilterButton(state: .notActivated)
    }()
    
    private let targetLocation = YMKPoint(latitude: 59.945933, longitude: 30.320045)
    private let locationManager = CLLocationManager()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
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
