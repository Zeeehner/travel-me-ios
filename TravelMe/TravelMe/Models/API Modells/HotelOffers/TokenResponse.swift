//
//  TokenResponses.swift
//  TravelMe
//
//  Created by Noah Ra on 23.01.25.
//

import Foundation

struct TokenResponse: Codable {
    
    let access_token: String
    let expires_in: Int
    let token_type: String
}
