//
//  APIRepository.swift
//  TravelMe
//
//  Created by Noah Ra on 23.01.25.
//

import Foundation

class APIClient {
    
    private var accessToken: String?
    private var tokenExpiryDate: Date?
    
    private let clientId = "***REMOVED***"
    private let baseUrl = "https://test.api.amadeus.com/v1/reference-data/locations/hotels/by-city"
    
    init() {
        Task {
            do {
                try await fetchAccessToken()
            } catch {
                print("Token fetch failed: \(error)")
            }
        }
    }
    
    private func fetchAccessToken() async throws {
        guard let url = URL(string: "https://test.api.amadeus.com/v1/security/oauth2/token") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let body = "grant_type=client_credentials&client_id=\(clientId)&client_secret=***REMOVED***"
        request.httpBody = body.data(using: .utf8)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
        
        accessToken = tokenResponse.access_token
        tokenExpiryDate = Date().addingTimeInterval(TimeInterval(tokenResponse.expires_in))
    }
    
    private func getAccessToken() async throws -> String {
        if let token = accessToken, let expiryDate = tokenExpiryDate, Date() < expiryDate {
            return token
        }
        
        try await fetchAccessToken()
        return accessToken ?? ""
    }
    
    func fetchHotelData() async -> [Hotel]? {
        do {
            let token = try await getAccessToken()
            
//            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            guard let url = URL(string: "\(baseUrl)?cityCode=PAR&radius=100") else {
                print("Invalid URL")
                return nil
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let welcome = try JSONDecoder().decode(HotelResponse.self, from: data)
            
            return welcome.data
        } catch {
            print("Error fetching hotel data: \(error)")
            return nil
        }
    }
}
