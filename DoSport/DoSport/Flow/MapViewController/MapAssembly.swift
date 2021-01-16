//
//  MapAssembly.swift
//  DoSport
//
//  Created by Sergey on 14.01.2021.
//

import Foundation

final class MapAssembly: Assembly {
    func makeModule() -> MapViewController {
        let viewModel = MapViewModel()
        let vc = MapViewController(viewModel: viewModel)
        return vc
    }
}
