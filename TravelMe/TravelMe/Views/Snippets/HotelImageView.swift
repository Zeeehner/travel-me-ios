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
            if !viewModel.imageUrl.isEmpty {
                AsyncImage(url: URL(string: viewModel.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 100)
                .cornerRadius(8)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchHotelImage(hotelName: hotelName)
            }
        }
    }
}


#Preview {
    HotelImageView(hotelName: "Paris")
}
