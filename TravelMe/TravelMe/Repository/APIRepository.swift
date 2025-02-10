//
//  APIRepository.swift
//  TravelMe
//
//  Created by Noah Ra on 23.01.25.
//

import Foundation

/// APIClient manages API requests and authentication for accessing the Amadeus API.
class APIClient {
    
    /// Stores the OAuth access token and its expiration date.
    private var accessToken: String?
    private var tokenExpiryDate: Date?
    
    /// The client ID used for authentication with the Amadeus API.
    private let clientId = "***REMOVED***"
    
    /// Base URL for fetching hotel data by city.
    private let baseUrl = "https://test.api.amadeus.com/v1/reference-data/locations/hotels/by-city"
    
    /// Initializes the API client and fetches an access token asynchronously.
    init() {
        Task {
            do {
                try await fetchAccessToken()
            } catch {
                print("Token fetch failed: \(error)")
            }
        }
    }
    
    /// Fetches a new access token from the Amadeus authentication API.
    private func fetchAccessToken() async throws {
        guard let url = URL(string: "https://test.api.amadeus.com/v1/security/oauth2/token") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // The request body contains the client ID and secret for authentication.
        let body = "grant_type=client_credentials&client_id=\(clientId)&client_secret=***REMOVED***"
        request.httpBody = body.data(using: .utf8)
        
        // Sends the request and decodes the response.
        let (data, _) = try await URLSession.shared.data(for: request)
        let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
        
        // Stores the new access token and calculates its expiration time.
        accessToken = tokenResponse.access_token
        tokenExpiryDate = Date().addingTimeInterval(TimeInterval(tokenResponse.expires_in))
    }
    
    /// Retrieves a valid access token, refreshing it if necessary.
    private func getAccessToken() async throws -> String {
        if let token = accessToken, let expiryDate = tokenExpiryDate, Date() < expiryDate {
            return token
        }
        
        try await fetchAccessToken()
        return accessToken ?? ""
    }
    
    /// Fetches hotel data for a specific city (e.g., Paris) with a given radius.
    func fetchHotelData() async -> [Hotel]? {
        do {
            let token = try await getAccessToken()
            guard let url = URL(string: "\(baseUrl)?cityCode=PAR&radius=100") else {
                print("Invalid URL")
                return nil
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let welcome = try JSONDecoder().decode(HotelResponse.self, from: data)
            
            if let hotels = welcome.data {
                // Filters out test properties or demo entries.
                let filteredHotels = hotels.filter { hotel in
                    !hotel.name.lowercased().contains("test property") &&
                    !hotel.name.lowercased().contains("demo") &&
                    !hotel.name.contains("Property") &&
                    !hotel.name.contains("test")
                }
                return filteredHotels
            } else {
                print("No hotels data available.")
                return nil
            }
        } catch {
            print("Error fetching hotel data: \(error)")
            return nil
        }
    }
}
