//
//  MapFilterAssembly.swift
//  DoSport
//
//  Created by Sergey on 18.02.2021.
//

import Foundation

final class MapFilterAssembly: Assembly {
    func makeModule() -> MapFilterViewController {
        let viewModel = MapFilterViewModel()
        let vc = MapFilterViewController(viewModel: viewModel)
        return vc
    }
}

