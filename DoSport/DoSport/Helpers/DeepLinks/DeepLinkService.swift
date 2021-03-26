//
//  DeepLinkService.swift
//  DoSport
//
//  Created by Maxim Safronov on 20.03.2021.
//

import Foundation

enum DeepLink {
    enum Url {
        static let event = "dosport://feed/event/"
    }
}
 
final class DeepLinkComponents {
    var url: URL
    var coordinator: AppCoordinator?
    
    init(url: URL, coordinator: AppCoordinator) {
        self.url = url
        self.coordinator = coordinator
    }
}

protocol DeepLinkDestinationProtocol {
    func getDestination(components: DeepLinkComponents)
}

protocol DeepLinkServiceProtocol: class {
    func handleURL(with components: DeepLinkComponents)
}

class DeepLinkService: DeepLinkServiceProtocol {
    
    var destinations: [DeepLinkDestinationProtocol]
    
    init(destinations: [DeepLinkDestinationProtocol]) {
        self.destinations = destinations
    }
    
    func handleURL(with components: DeepLinkComponents) {
        destinations.forEach { destination in
            destination.getDestination(components: components)
        }
    }
}
