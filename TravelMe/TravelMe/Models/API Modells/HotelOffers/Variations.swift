//
//  Variations.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Variations: Codable, Identifiable {
    
    var id: UUID { UUID() }
    let average: Average
    let changes: [Change]
}
