//
//  Cancellation.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Cancellation: Codable, Identifiable {
    var id: UUID { UUID() }
    let numberOfNights: Int
    let deadline: Date
    let amount, policyType: String
}
