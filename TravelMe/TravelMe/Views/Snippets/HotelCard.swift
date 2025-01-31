//
//  HotelCard.swift
//  TravelMe
//
//  Created by Noah Ra on 17.01.25.
//

import SwiftUI

struct HotelCard: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var hotelViewModel: HotelViewModel
    
    let index: Int

    var body: some View {
        NavigationStack {
            if hotelViewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                if index < hotelViewModel.hotels.count {
                    let hotel = hotelViewModel.hotels[index]

                    NavigationLink(destination: ShowcaseView(
                        homeViewModel: homeViewModel,
                        hotelViewModel: hotelViewModel,
                        selectedIndex: index
                    )) {
                        VStack {
                            if let imageUrl = hotel.images?.first?.url, let url = URL(string: imageUrl) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                         .scaledToFill()
                                         .frame(width: 150, height: 110)
                                         .cornerRadius(8)
                                         .shadow(radius: 2)
                                } placeholder: {
                                    Rectangle()
                                        .fill(.gray.opacity(0.3))
                                        .frame(width: 150, height: 110)
                                        .cornerRadius(8)
                                }
                            } else {
                                Rectangle()
                                    .fill(.white.opacity(0.6))
                                    .frame(width: 150, height: 110)
                                    .cornerRadius(8)
                                    .shadow(radius: 2)
                                    .overlay(
                                        Text("No image available")
                                            .foregroundStyle(.black)
                                    )
                            }
                            Text(hotel.name)
                                .foregroundStyle(.black)
                                .padding(.top, 5)
                                .frame(width: 150)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                } else {
                    Text("Hotel not found")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    HotelCard(homeViewModel: .init(firestoreRepository: .init()), hotelViewModel: .init(), index: 1)
}
