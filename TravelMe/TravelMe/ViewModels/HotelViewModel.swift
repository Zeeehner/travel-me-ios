//
//  HotelViewModel.swift
//  TravelMe
//
//  Created by Noah Ra on 23.01.25.
//

import Foundation

@MainActor
class HotelViewModel: ObservableObject {
    
    private var apiClient: APIClient
    @Published var hotels: [Datum] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    init(apiClient: APIClient = APIClient(completion: {})) {
        self.apiClient = apiClient
        apiClient.fetchAccessToken {
            print("Access token fetched successfully.")
        }
    }
    
    func loadHotelData() {
        isLoading = true
        print("Attempting to load hotel data...")
        apiClient.fetchHotelData { [weak self] hotels in
            DispatchQueue.main.async {
                print("Fetch hotel data completed")
                if let hotels = hotels {
                    print("Hotels received: \(hotels.count)")
                    self?.hotels = hotels
                } else {
                    print("No hotels retrieved")
                    self?.errorMessage = "Error retrieving hotel data."
                }
                self?.isLoading = false
            }
        }
    }
}

