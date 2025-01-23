//
//  Description.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Description: Codable, Identifiable {
    
    var id: UUID { UUID() }
    let text, lang: String
}
