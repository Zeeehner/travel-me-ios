//
//  Refundable.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Refundable: Codable, Identifiable {
    
    let id: String
    let cancellationRefund: String
}
