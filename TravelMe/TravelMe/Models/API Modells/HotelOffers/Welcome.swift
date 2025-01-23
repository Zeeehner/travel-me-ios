//
//  Welcome.swift
//  TravelMe
//
//  Created by Noah Ra on 23.01.25.
//

import Foundation

struct Welcome: Codable, Identifiable {
    
    var id: UUID { UUID() }
    let data: [Datum]
}
