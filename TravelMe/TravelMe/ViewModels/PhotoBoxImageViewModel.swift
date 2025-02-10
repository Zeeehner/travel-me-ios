//
//  PhotoBoxImageViewModel.swift
//  TravelMe
//
//  Created by Noah Ra on 31.01.25.
//

import Foundation

@MainActor
// PhotoBoxImageViewModel is responsible for fetching and managing image URLs from Unsplash
class PhotoBoxImageViewModel: ObservableObject {
    
    // Published property that stores the URL of the image to be displayed
    @Published var imageUrl: String = ""
    
    // API key for accessing the Unsplash API (assumed to be defined elsewhere)
    private let apiKey = unsplashedKey

    // Function to fetch an image from Unsplash based on the photo name
    func fetchImage(photoName: String) async {
        // Construct the URL string for the Unsplash API search request
        let urlString = "https://api.unsplash.com/search/photos?query=\(photoName)&client_id=\(apiKey)"
        
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            print("Invalid URL") // Print error if the URL is invalid and return
            return
        }

        do {
            // Asynchronously fetch data from the URL (Unsplash API)
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode the received JSON data into an UnsplashResponse object
            let response = try JSONDecoder().decode(UnsplashResponse.self, from: data)
            
            // If there are results, set the imageUrl to the URL of the first image in the response
            if let firstImage = response.results.first {
                self.imageUrl = firstImage.urls.small // Set the image URL to the small version of the image
            }
        } catch {
            // Handle any errors that occur during the fetch or decoding process
            print("Error fetching image: \(error)") // Print the error message
        }
    }
}
