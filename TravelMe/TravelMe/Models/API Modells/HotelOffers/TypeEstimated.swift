//
//  TypeEstimated.swift
//  TravelMe
//
//  Created by Noah Ra on 21.01.25.
//

import Foundation

struct TypeEstimated: Codable, Identifiable {
    let id: String
    let category: String
    let beds: Int
    let bedType: String
}
