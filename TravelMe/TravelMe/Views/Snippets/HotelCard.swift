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
                    NavigationLink(destination: ShowcaseView(
                        homeViewModel: homeViewModel,
                        hotelViewModel: hotelViewModel,
                        selectedIndex: index
                    )) {
                        VStack {
                            Rectangle()
                                .fill(Color.white.opacity(0.6))
                                .frame(width: 150, height: 110)
                                .aspectRatio(1.0, contentMode: .fit)
                                .overlay(
                                    Text("MusterPicture")
                                        .foregroundStyle(.black)
                                )
                                .cornerRadius(8)
                                .shadow(radius: 2)
                            Text("\(hotelViewModel.hotels[index].name)")
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
