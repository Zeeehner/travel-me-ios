//
//  CityCodes.swift
//  TravelMe
//
//  Created by Noah Ra on 31.01.25.
//

import Foundation

let cityCodes: [String: String] = [
    "Paris": "PAR",
    "Berlin": "BER",
    "London": "LON",
    "New York": "NYC",
    "Dubai": "DXB",
    "Istanbul": "IST"
]

func getCityCode(for cityName: String) -> String? {
    return cityCodes[cityName]
}
