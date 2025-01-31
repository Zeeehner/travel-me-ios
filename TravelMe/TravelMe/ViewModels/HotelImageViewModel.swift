//
//  HotelImageViewModel.swift
//  TravelMe
//
//  Created by Noah Ra on 31.01.25.
//

import Foundation

class HotelImageViewModel: ObservableObject {
    
    @Published var imageUrl: String = ""
    
    private let apiKey = unsplashedKey

    func fetchHotelImage(hotelName: String) async {
        let urlString = "https://api.unsplash.com/search/photos?query=\(hotelName)&client_id=\(apiKey)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(UnsplashResponse.self, from: data)
            
            if let firstImage = response.results.first {
                self.imageUrl = firstImage.urls.small
            }
        } catch {
            print("Error fetching image: \(error)")
        }
    }
}
