//
//  HotelListView.swift
//  TravelMe
//
//  Created by Noah Ra on 11.02.25.
//

import SwiftUI

struct HotelListView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var hotelViewModel: HotelViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientView()
                    .edgesIgnoringSafeArea(.all)
                
                if hotelViewModel.isLoading {
                    ProgressView("Loading hotels...")
                        .padding()
                } else if !hotelViewModel.errorMessage.isEmpty {
                    Text(hotelViewModel.errorMessage)
                        .foregroundStyle(.red)
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(hotelViewModel.hotels.indices, id: \.self) { index in
                                NavigationLink(destination: DashboardView(homeViewModel: homeViewModel, hotelViewModel: hotelViewModel, selectedIndex: index)) {
                                    HotelRowView(hotel: hotelViewModel.hotels[index])
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                hotelViewModel.loadHotelData()
            }
        }
        .navigationTitle("Travel Me")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HotelListView(homeViewModel: .init(firestoreRepository: .init()), hotelViewModel: .init())
}
