//
//  RateFamilyEstimated.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct RateFamilyEstimated: Codable, Identifiable {
    
    var id: UUID { UUID() }
    let code, type: String
}
