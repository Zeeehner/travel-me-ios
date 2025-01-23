//
//  Change.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Change: Codable, Identifiable {
    let id: String
    let startDate, endDate, base: String
}
