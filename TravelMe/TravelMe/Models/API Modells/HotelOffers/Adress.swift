//
//  Adress.swift
//  TravelMe
//
//  Created by Noah Ra on 24.01.25.
//

import Foundation

struct Address: Codable {
    let countryCode: String

    
    enum CodingKeys: String, CodingKey {
        case countryCode

    
    }
}
