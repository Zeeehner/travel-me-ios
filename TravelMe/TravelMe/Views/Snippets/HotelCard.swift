//
//  HotelCard.swift
//  TravelMe
//
//  Created by Noah Ra on 17.01.25.
//

import SwiftUI

struct HotelCard: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: ShowcaseView(homeViewModel: homeViewModel)) {
                VStack {
                    Rectangle()
                        .fill(.white.opacity(0.6))
                        .frame(width: 150, height: 110)
                        .aspectRatio(1.0, contentMode: .fit)
                        .overlay(
                            Text("Musterhotel")
                                .foregroundStyle(.black)
                        )
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    Text("HotelName")
                        .foregroundStyle(.black)
                }
                
            }
        }
    }
}


#Preview {
    HotelCard(homeViewModel: HomeViewModel(firestoreRepository: .init()))
}
