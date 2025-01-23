//
//  Description.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Description: Codable, Identifiable {
    let id: String
    let text, lang: String
}
