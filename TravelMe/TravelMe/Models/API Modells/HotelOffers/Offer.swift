//
//  Offer.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Offer: Codable {
    let id, checkInDate, checkOutDate, rateCode: String
    let rateFamilyEstimated: RateFamilyEstimated
    let room: Room
    let guests: Guests
    let price: Price
    let policies: Policies
    let offerSelf: String
    
    
    enum CodingKeys: String, CodingKey {
        case id, checkInDate, checkOutDate, rateCode, rateFamilyEstimated, room, guests, price, policies
        case offerSelf = "self"
    }
}
