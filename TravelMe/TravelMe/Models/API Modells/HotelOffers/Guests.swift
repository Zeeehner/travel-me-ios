//
//  Guests.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Guests: Codable, Identifiable {
    
    var id: UUID { UUID() }
    let adults: Int
}
