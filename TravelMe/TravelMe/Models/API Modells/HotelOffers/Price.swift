//
//  Price.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Price: Codable, Identifiable {
    let id: String
    let currency, base, total: String
    let variations: Variations
}
