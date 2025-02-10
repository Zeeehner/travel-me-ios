//
//  HotelImageView.swift
//  TravelMe
//
//  Created by Noah Ra on 31.01.25.
//

import SwiftUI

struct HotelImageView: View {
    
    @StateObject private var viewModel = HotelImageViewModel()
    let hotelName: String

    var body: some View {
        VStack {
            // Check if image URL is not empty
            if !viewModel.imageUrl.isEmpty {
                // AsyncImage will load the image from the URL
                AsyncImage(url: URL(string: viewModel.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped() // Ensure image is clipped if it overflows the frame
                } placeholder: {
                    // Show a loading spinner while the image is being loaded
                    ProgressView()
                }
                .frame(width: 150, height: 100) // Set fixed size for the image
                .cornerRadius(8) // Apply corner radius to the image for a rounded effect
            } else {
                // Show a loading spinner if the URL is empty or the image is not loaded yet
                ProgressView()
            }
        }
        .onAppear {
            // Fetch hotel image when the view appears
            Task {
                await viewModel.fetchHotelImage(hotelName: hotelName)
            }
        }
    }
}



#Preview {
    HotelImageView(hotelName: "Paris")
}
