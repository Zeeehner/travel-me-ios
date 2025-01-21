//
//  Hotel.swift
//  TravelMe
//
//  Created by Noah Ra on 15.01.25.
//

import Foundation
import MapKit

struct Hotels: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

extension Hotels {
    static let samples = [
        Hotels(name: "Grand Hotel Berlin", coordinate: CLLocationCoordinate2D(latitude: 52.5200, longitude: 13.4050)),
        Hotels(name: "Hotel Adlon", coordinate: CLLocationCoordinate2D(latitude: 52.5163, longitude: 13.3777)),
        Hotels(name: "Ritz Carlton", coordinate: CLLocationCoordinate2D(latitude: 52.5097, longitude: 13.3756))
    ]
}
