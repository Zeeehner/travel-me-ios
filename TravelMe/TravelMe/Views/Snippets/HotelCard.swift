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
    
    var body: some View {
        NavigationStack {
            if hotelViewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let firstHotel = hotelViewModel.hotels.first {
                NavigationLink(destination: ShowcaseView(homeViewModel: homeViewModel)) {
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
                        Text(firstHotel.name)
                            .foregroundStyle(.black)
                            .padding(.top, 5)
                    }
                }
            } else {
                Rectangle()
                    .fill(Color.white.opacity(0.6))
                    .frame(width: 150, height: 110)
                    .aspectRatio(1.0, contentMode: .fit)
                    .overlay(
                        VStack {
                            Text("No hotel found")
                                .foregroundStyle(.cyan.opacity(0.6))
                        }
                            )
                        
                    .cornerRadius(8)
                    .shadow(radius: 2)
            }
                        
        }
    }
}




#Preview {
    HotelCard(homeViewModel: .init(firestoreRepository: .init()), hotelViewModel: .init())
}
