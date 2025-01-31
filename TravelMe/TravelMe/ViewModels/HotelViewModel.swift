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
    private var dataLoaded = false 
    
    @Published var hotels: [Hotel] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false

    
    init() {
        self.apiClient = APIClient()
    }
    
    func loadHotelData() {
        guard !dataLoaded else { return }
        
        Task {
            isLoading = true
            print("Attempting to load hotel data...")
            
            do {
                if let hotels = try await apiClient.fetchHotelData() {
                    print("Hotels received: \(hotels.count)")
                    self.hotels = hotels
                    self.dataLoaded = true 
                } else {
                    print("No hotels retrieved")
                    self.errorMessage = "Error retrieving hotel data."
                }
            } catch {
                print("Error loading hotels: \(error)")
                self.errorMessage = "Error loading hotels: \(error.localizedDescription)"
            }
            
            isLoading = false
        }
    }
    // Optional: Add method to force reload if needed
    func forceReload() {
        dataLoaded = false
        loadHotelData()
    }
}

