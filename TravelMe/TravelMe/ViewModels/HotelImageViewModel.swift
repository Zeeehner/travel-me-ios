//
//  HotelImageViewModel.swift
//  TravelMe
//
//  Created by Noah Ra on 31.01.25.
//

import SwiftUI

@MainActor
// HotelImageViewModel is responsible for fetching and managing the image URL for a hotel
class HotelImageViewModel: ObservableObject {
    
    // Published property to store the image URL that will trigger UI updates when changed
    @Published var imageUrl: String = ""
    
    // API key for accessing the Unsplash API (assuming the key is defined elsewhere)
    private let apiKey = unsplashedKey

    // Function to fetch an image based on the hotel name
    func fetchHotelImage(hotelName: String) async {
        // Construct the URL string for the Unsplash API search request
        let urlString = "https://api.unsplash.com/search/photos?query=\(hotelName)&client_id=\(apiKey)"
        
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            print("Invalid URL") // If the URL is invalid, print an error and return
            return
        }

        do {
            // Asynchronously fetch the data from the Unsplash API
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode the received data into the UnsplashResponse model
            let response = try JSONDecoder().decode(UnsplashResponse.self, from: data)
            
            // If the response contains results, set the imageUrl to the URL of the first image
            if let firstImage = response.results.first {
                await MainActor.run {
                    self.imageUrl = firstImage.urls.small
                }
            }
        } catch {
            // Handle any errors that occur during the fetch or decoding process
            print("Error fetching image: \(error)")
        }
    }
}
