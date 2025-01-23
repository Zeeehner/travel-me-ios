//
//  Room.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Room: Codable, Identifiable {
    
    var id: UUID { UUID() }
    let type: String
    let typeEstimated: TypeEstimated
    let description: Description
}
