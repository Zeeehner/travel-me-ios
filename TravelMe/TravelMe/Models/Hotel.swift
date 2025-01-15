//
//  Hotel.swift
//  TravelMe
//
//  Created by Noah Ra on 15.01.25.
//

import Foundation
import MapKit

struct Hotel: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

extension Hotel {
    static let samples = [
        Hotel(name: "Grand Hotel Berlin", coordinate: CLLocationCoordinate2D(latitude: 52.5200, longitude: 13.4050)),
        Hotel(name: "Hotel Adlon", coordinate: CLLocationCoordinate2D(latitude: 52.5163, longitude: 13.3777)),
        Hotel(name: "Ritz Carlton", coordinate: CLLocationCoordinate2D(latitude: 52.5097, longitude: 13.3756))
    ]
}
