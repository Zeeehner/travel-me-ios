//
//  SearchScreen.swift
//  TravelMe
//
//  Created by Noah Ra on 15.01.25.
//

import SwiftUI
import FirebaseCore

struct SearchView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var hotelViewModel: HotelViewModel
    
    let labels = ["Germany", "Austria", "UK", "Dubai", "Istanbul", "Egypt"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientView()
                    .opacity(0.4)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        // Title of the page
                        Text("Travel Me")
                            .font(.headline)
                            .padding(.bottom, 8)
                        
                        // Scrollable buttons for country selection
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(0..<labels.count, id: \.self) { index in
                                    Button(action: {
                                        homeViewModel.selectedLabel = index
                                    }) {
                                        Text(labels[index])
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(homeViewModel.selectedLabel == index ? .blue : .white.opacity(0.8))
                                            .foregroundStyle(homeViewModel.selectedLabel == index ? .white : .black)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 40)
                        
                        Divider()
                        
                        // SearchBox for destination and other filters
                        SearchBox(homeViewModel: homeViewModel, hotelViewModel: hotelViewModel)
                        
                        Divider()
                        
                        // Featured Hotels Section
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 20) {
                                VStack(alignment: .leading) {
                                    Text("Featured Hotels")
                                        .font(.headline)
                                        .padding(.horizontal)
                                    
                                    // Horizontal scroll for featured hotels
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        LazyHStack(spacing: 16) {
                                            ForEach(0..<min(5, hotelViewModel.hotels.count), id: \.self) { index in
                                                HotelCard(homeViewModel: homeViewModel,
                                                          hotelViewModel: hotelViewModel,
                                                          index: index)
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                
                                Divider()
                                
                                // All Hotels Section
                                VStack(alignment: .leading) {
                                    Text("All Hotels")
                                        .font(.headline)
                                        .padding(.horizontal)
                                    
                                    // Grid of all hotels
                                    LazyVGrid(columns: [
                                        GridItem(.flexible()),
                                        GridItem(.flexible())
                                    ], spacing: 16) {
                                        ForEach(0..<min(200, hotelViewModel.hotels.count), id: \.self) { index in
                                            HotelCard(homeViewModel: homeViewModel,
                                                      hotelViewModel: hotelViewModel,
                                                      index: index)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                // Load hotel data when the view appears
                hotelViewModel.loadHotelData()
            }
        }
    }
}


#Preview {
    SearchView(homeViewModel: HomeViewModel(firestoreRepository: .init()), hotelViewModel: .init())
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
