//
//  HotelViewModel.swift
//  TravelMe
//
//  Created by Noah Ra on 23.01.25.
//

import Foundation

@MainActor
// HotelViewModel is responsible for managing the data related to hotels and handling UI updates
class HotelViewModel: ObservableObject {
    
    // APIClient instance for making network requests to fetch hotel data
    private var apiClient: APIClient
    
    // Published properties that trigger UI updates when they change
    @Published var hotels: [Hotel] = [] // List of hotels that will be displayed
    @Published var errorMessage: String = "" // Error message to display if something goes wrong
    @Published var isLoading: Bool = false // Boolean to indicate if data is loading
    private var dataLoaded = false // Flag to ensure data is loaded only once
    
    // Initializer to create an instance of APIClient
    init() {
        self.apiClient = APIClient()
    }
    
    // Function to load hotel data from the API
    func loadHotelData() {
        // Prevent reloading if the data has already been loaded
        guard !dataLoaded else { return }
        
        // Start an asynchronous task to fetch the hotel data
        Task {
            isLoading = true // Set loading state to true
            print("Attempting to load hotel data...")
            
            do {
                // Fetch hotel data from the API using the APIClient
                if let hotels = try await apiClient.fetchHotelData() {
                    print("Hotels received: \(hotels.count)") // Print number of hotels received
                    self.hotels = hotels // Update the list of hotels
                    self.dataLoaded = true // Set flag to indicate data is loaded
                } else {
                    // If no hotels are retrieved, show an error message
                    print("No hotels retrieved")
                    self.errorMessage = "Error retrieving hotel data."
                }
            } catch {
                // Handle any errors that occur during the data loading process
                print("Error loading hotels: \(error)")
                self.errorMessage = "Error loading hotels: \(error.localizedDescription)"
            }
            
            isLoading = false // Set loading state to false after the operation is complete
        }
    }
    
    func loadHotels(for cityName: String) {
        guard let cityCode = getCityCode(for: cityName) else {
            self.errorMessage = "City not found."
            return
        }
        
        Task {
            isLoading = true
            print("Fetching hotels for city: \(cityCode)")
            
            do {
                if let hotels = await apiClient.fetchHotelDataForCity(for: cityCode) {
                    self.hotels = hotels
                } else {
                    self.errorMessage = "No hotels found."
                }
            } catch {
                self.errorMessage = "Error loading hotels: \(error.localizedDescription)"
            }
            
            isLoading = false
        }
    }
    func loadHotelDataForCity(for cityName: String) {
        Task {
            isLoading = true
            
            guard !cityName.isEmpty else {
                self.errorMessage = "Please enter a valid city name."
                isLoading = false
                return
            }
            
            do {
                if let hotels = try await apiClient.fetchHotelDataForCity(for: cityName) {
                    print("searching \(cityName) 🛩️ Hotels received: \(hotels.count)")
                    self.hotels = hotels
                } else {
                    self.errorMessage = "No hotels found."
                }
            } catch {
                self.errorMessage = "Error loading hotels: \(error.localizedDescription)"
            }
            
        
            isLoading = false
        }
    }
}
