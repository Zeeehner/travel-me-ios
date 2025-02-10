//
//  TokenManager.swift
//  TravelMe
//
//  Created by Noah Ra on 28.01.25.
//

import Foundation

// TokenManager actor handles the access token retrieval and refresh process
actor TokenManager {
    
    // Private variables to store the access token and its expiry date
    private var accessToken: String?
    private var tokenExpiryDate: Date?
    
    // Public function to get a valid access token
    func getValidToken() async throws -> String {
        // Check if there's an existing token and it's still valid (not expired)
        if let token = accessToken,
           let expiryDate = tokenExpiryDate,
           Date() < expiryDate {
            // Return the existing token if it hasn't expired
            return token
        }
        // If no valid token exists, refresh the token by calling refreshToken() function
        return try await refreshToken()
    }
    
    // Private function to refresh the access token if it's expired or missing
    private func refreshToken() async throws -> String {
        // Construct the URL for the token request
        guard let url = URL(string: "\(APIConfig.baseURL)/security/oauth2/token") else {
            // If the URL is invalid, throw an error
            throw NetworkError.invalidURL
        }
        
        // Create a URLRequest with the constructed URL
        var request = URLRequest(url: url)
        // Set the HTTP method to POST (standard for OAuth2 token requests)
        request.httpMethod = "POST"
        // Set the Content-Type header for the request body format
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Create the body of the POST request with required parameters
        let body = [
            "grant_type": "client_credentials",  // OAuth2 grant type
            "client_id": APIConfig.clientId,     // Client ID from the API configuration
            "client_secret": APIConfig.clientSecret  // Client secret from the API configuration
        ]
            .map { "\($0)=\($1)" }  // Convert the parameters to "key=value" format
            .joined(separator: "&") // Join the key-value pairs with '&' separator
        
        // Convert the body to Data and assign it to the HTTP request body
        request.httpBody = body.data(using: .utf8)
        
        do {
            // Send the request and await the response (asynchronously)
            let (data, _) = try await URLSession.shared.data(for: request)
            // Decode the JSON response into a TokenResponse object
            let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
            
            // Save the access token and calculate its expiry date
            accessToken = tokenResponse.access_token
            tokenExpiryDate = Date().addingTimeInterval(TimeInterval(tokenResponse.expires_in))
            
            // Return the newly fetched access token
            return tokenResponse.access_token
        } catch {
            // If any error occurs during the request or decoding, throw a general network error
            throw NetworkError.unknown(error)
        }
    }
}
