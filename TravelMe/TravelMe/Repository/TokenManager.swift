//
//  TokenManager.swift
//  TravelMe
//
//  Created by Noah Ra on 28.01.25.
//

import Foundation

actor TokenManager {
    
    private var accessToken: String?
    private var tokenExpiryDate: Date?
    
    func getValidToken() async throws -> String {
        if let token = accessToken,
           let expiryDate = tokenExpiryDate,
           Date() < expiryDate {
            return token
        }
        return try await refreshToken()
    }
    
    private func refreshToken() async throws -> String {
        guard let url = URL(string: "\(APIConfig.baseURL)/security/oauth2/token") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "grant_type": "client_credentials",
            "client_id": APIConfig.clientId,
            "client_secret": APIConfig.clientSecret
        ]
            .map { "\($0)=\($1)" }
            .joined(separator: "&")
        
        request.httpBody = body.data(using: .utf8)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
            
            accessToken = tokenResponse.access_token
            tokenExpiryDate = Date().addingTimeInterval(TimeInterval(tokenResponse.expires_in))
            
            return tokenResponse.access_token
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
