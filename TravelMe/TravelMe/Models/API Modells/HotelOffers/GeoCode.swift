//
//  GeoCode.swift
//  TravelMe
//
//  Created by Noah Ra on 24.01.25.
//

import Foundation

struct GeoCode: Codable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}
