//
//  FavoriteView.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import SwiftUI
import FirebaseCore

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
                            ForEach(0..<4) { _ in
                                NavigationLink(destination: ShowcaseView(homeViewModel: homeViewModel)) {
                                    HotelCard(homeViewModel: homeViewModel, hotelViewModel: hotelViewModel)
                                }
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Favorites")
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    FavoriteView(homeViewModel: HomeViewModel(firestoreRepository: .init()), hotelViewModel: .init())
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
