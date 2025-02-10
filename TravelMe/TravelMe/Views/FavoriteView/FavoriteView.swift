//
//  FavoriteView.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import SwiftUI
import FirebaseCore

// FavoriteView displays a list of favorite hotels in a grid layout
struct FavoriteView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var hotelViewModel: HotelViewModel
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientView()
                    .opacity(0.4)
                
                VStack(spacing: 0) {
                    Searchbar(homeViewModel: homeViewModel)
                    
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(0..<min(4, hotelViewModel.hotels.count), id: \.self) { index in
                                HotelCard(homeViewModel: homeViewModel,
                                          hotelViewModel: hotelViewModel,
                                          index: index)
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Favorites")
                    .navigationBarTitleDisplayMode(.inline)
                    Spacer()
                }
            }
            .onAppear {
                hotelViewModel.loadHotelData() 
            }
        }
    }
}

#Preview {
    FavoriteView(homeViewModel: HomeViewModel(firestoreRepository: .init()),
                 hotelViewModel: .init())
    .environmentObject(AuthViewModel(authRepository: .init(),
                                     firestoreRepository: .init()))
}
