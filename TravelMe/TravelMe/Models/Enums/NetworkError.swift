//
//  NetworkError.swift
//  TravelMe
//
//  Created by Noah Ra on 28.01.25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case unauthorized
    case invalidToken
    case unknown(Error)
}
