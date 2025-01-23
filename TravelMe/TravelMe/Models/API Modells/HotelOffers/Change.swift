//
//  Change.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Change: Codable, Identifiable {
//    var id:String
    var id: UUID { UUID() }
    let startDate, endDate, base: String
}
