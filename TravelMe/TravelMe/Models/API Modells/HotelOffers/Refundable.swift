//
//  Refundable.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Refundable: Codable, Identifiable {
    
    var id: UUID { UUID() }
    let cancellationRefund: String
}
