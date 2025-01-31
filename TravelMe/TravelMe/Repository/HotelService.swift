//
//  HotelService.swift
//  TravelMe
//
//  Created by Noah Ra on 31.01.25.
//

import Foundation
import Amadeus

class HotelService {
    
    private let amadeus = Amadeus(client_id: "***REMOVED***", client_secret: "0x4XR25goUJEfAMv")
    
    func fetchHotels(cityCode: String) async throws -> [Hotel]? {
        return try await withCheckedThrowingContinuation { continuation in
            amadeus.shopping.hotelOffers.get(params: ["cityCode": cityCode]) { result in
                switch result {
                case .success(let response):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: response.data)
                        let hotels = try JSONDecoder().decode(HotelResponse.self, from: jsonData)
                        
                        print("Loaded hotels with images: \(hotels)")
                        continuation.resume(returning: hotels.data)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
