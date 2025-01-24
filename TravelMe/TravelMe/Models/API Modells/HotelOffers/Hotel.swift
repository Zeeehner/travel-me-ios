//
//  Hotel.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Hotel: Codable, Identifiable {
    var id: UUID { UUID() }
    let type, hotelId, chainCode, dupeID, iataCode, lastUpdate: String
    let name, cityCode: String
    let latitude, longitude: Double
    let geoCode: GeoCode
    let address: Address
    
    
    enum CodingKeys: String, CodingKey {
        
        case type
        case hotelId = "hotelId"
        case chainCode
        case dupeID = "dupeId"
        case iataCode
        case lastUpdate
        case name, cityCode, latitude, longitude
        case geoCode
        case address
    }
}
