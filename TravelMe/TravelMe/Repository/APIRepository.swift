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
    // base URL // https://test.api.amadeus.com/v3/shopping/hotel-offers
    private let baseUrl = "https://test.api.amadeus.com/v1/reference-data/locations/hotels/by-city"
    
    init(completion: @escaping() -> Void) {
        fetchAccessToken(completion: completion)
    }
    
    func fetchAccessToken(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://test.api.amadeus.com/v1/security/oauth2/token") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let body = "grant_type=client_credentials&client_id=\(clientId)&client_secret=***REMOVED***"
        request.httpBody = body.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                do {
                    let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.accessToken = tokenResponse.access_token
                        self.tokenExpiryDate = Date().addingTimeInterval(TimeInterval(tokenResponse.expires_in))
                        completion()
                    }
                } catch {
                    print("Decoding Error: \(error)")
                }
            } else if let error = error {
                print("Error while loading token: \(error)")
            }
        }
        task.resume()
    }
    
    func getAccessToken(completion: @escaping (String?) -> Void) {
        if let token = accessToken, let expiryDate = tokenExpiryDate, Date() < expiryDate {
            completion(token)
        } else {
            fetchAccessToken {
                completion(self.accessToken)
            }
        }
    }
    
    func fetchHotelData(completion: @escaping ([Datum]?) -> Void) {
        print("Starting fetchHotelData")
        getAccessToken { token in
            print("Token received: \(token != nil)")
            guard let token = token else {
                completion(nil)
                return
            }
                                            // URL(string: "\(self.baseUrl)?hotelIds=MCLONGHM&adults=1")
            let currentDate = Date()
            let formatter = DateFormatter()  // adults=1&cityCode=LON&checkInDate=2025-02-22&roomQuantity=1&hotelIds=MCLONGHM,IBLONH01,IBLONH02
                                                // https://test.api.amadeus.com/v1/reference-data/locations/hotels/by-city?cityCode=PAR

            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: currentDate.addingTimeInterval(30*24*60*60))
            guard let url =  URL(string: "\(self.baseUrl)?cityCode=PAR&radius=100&radiusUnit=KM" ) else {
                print("Invalid URL")
                completion(nil)
                return
            }
            
            print("Attempting to fetch from: \(url)")
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Network Error: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    completion(nil)
                    return
                }
                
                do {
                    let welcome = try JSONDecoder().decode(Welcome.self, from: data)
                    print("Successfully decoded \(welcome.data.count) hotels")
                    DispatchQueue.main.async {
                        completion(welcome.data)
                    }
                } catch {
                    print("Decoding Error: \(error)")
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Received JSON: \(jsonString)")
                    }
                    completion(nil)
                }
            }
            task.resume()
        }
    }
}
