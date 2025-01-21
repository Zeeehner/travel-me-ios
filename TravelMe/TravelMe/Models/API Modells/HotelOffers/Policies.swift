//
//  Policies.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct Policies: Codable {
    let cancellations: [Cancellation]
    let paymentType: String
    let refundable: Refundable
}
