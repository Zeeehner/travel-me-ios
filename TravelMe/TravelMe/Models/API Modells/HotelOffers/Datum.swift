//
//  Datum.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Datum: Codable, Identifiable {
//    var id: UUID { UUID() }
    var id: String { hotel.hotelId }
    let type: String
    let hotel: Hotel
    let available: Bool
//    let offers: [Offer]
    let datumSelf: String
    
    
    enum CodingKeys: String, CodingKey {
        
      case type, hotel, available//, offers
        case datumSelf = "self"
    }
}
