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
    
    init() async {
        self.apiClient = await APIClient()
        Task {
            await initializeClient()
        }
    }
    
    private func initializeClient() async {
        // Optional: Add any initialization logic if needed
    }
    
    func loadHotelData() {
        Task {
            isLoading = true
            print("Attempting to load hotel data...")
            
            do {
                if let hotels = await apiClient.fetchHotelData() {
                    print("Hotels received: \(hotels.count)")
                    self.hotels = hotels
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
}
