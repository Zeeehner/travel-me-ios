//
//  Hotel.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Hotel: Codable, Identifiable {
    var id: UUID { UUID() }
    let type, hotelID, chainCode, dupeID: String
    let name, cityCode: String
    let latitude, longitude: Double
    
    
    enum CodingKeys: String, CodingKey {
        
        case type
        case hotelID = "hotelId"
        case chainCode
        case dupeID = "dupeId"
        case name, cityCode, latitude, longitude
    }
}
