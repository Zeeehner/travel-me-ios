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
    "Istanbul": "IST",
    "Tokyo": "HND",
    "Singapore": "SIN",
    "Rome": "ROM",
    "Madrid": "MAD",
    "Moscow": "MOW",
    "Sydney": "SYD",
    "Mumbai": "BOM",
    "Toronto": "YYZ",
    "Shanghai": "SHA",
    "Barcelona": "BCN",
    "Amsterdam": "AMS",
    "Beijing": "PEK",
    "Melbourne": "MEL",
    "Kuala Lumpur": "KUL",
    "Frankfurt": "FRA",
    "Bangkok": "BKK",
    "Zurich": "ZRH",
    "Copenhagen": "CPH",
    "Vienna": "VIE",
    "Dubai": "DXB",
    "Rio de Janeiro": "RIO",
    "Athens": "ATH",
    "Los Angeles": "LAX",
    "San Francisco": "SFO",
    "Chicago": "ORD",
    "Atlanta": "ATL",
    "Dallas": "DFW",
    "Boston": "BOS",
    "Miami": "MIA",
    "Dallas/Fort Worth": "DFW",
    "Mexico City": "MEX",
    "Buenos Aires": "EZE",
    "Sao Paulo": "GRU",
    "Lagos": "LOS",
    "Johannesburg": "JNB",
    "Manila": "MNL",
    "New Delhi": "DEL",
    "Cape Town": "CPT",
    "Hong Kong": "HKG",
    "Jakarta": "CGK",
    "Seoul": "ICN"
]

func getCityCode(for cityName: String) -> String? {
    return cityCodes[cityName]
}
