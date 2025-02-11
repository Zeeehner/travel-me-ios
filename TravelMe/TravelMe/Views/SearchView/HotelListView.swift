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
    
    @State private var currentPage = 0
    private let hotelsPerPage = 10
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientView()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
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
                                let startIndex = currentPage * hotelsPerPage
                                let endIndex = min((currentPage + 1) * hotelsPerPage, hotelViewModel.hotels.count)
                                ForEach(startIndex..<endIndex, id: \.self) { index in
                                    NavigationLink(destination: DashboardView(homeViewModel: homeViewModel, hotelViewModel: hotelViewModel, selectedIndex: index)) {
                                        HotelRowView(hotel: hotelViewModel.hotels[index])
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    HStack {
                        Button(action: {
                            if currentPage > 0 {
                                currentPage -= 1
                            }
                        }) {
                            Text("Back")
                                .padding()
                                .frame(height: 40)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .cornerRadius(8)
                        }
                        .disabled(currentPage == 0)
                        .opacity(currentPage == 0 ? 0.1 : 1)
                        
                        Spacer()
                        
                        Button(action: {
                            if (currentPage + 1) * hotelsPerPage < hotelViewModel.hotels.count {
                                currentPage += 1
                            }
                        }) {
                            Text("Next")
                                .padding()
                                .frame(height: 40)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .cornerRadius(8)
                        }
                        .disabled((currentPage + 1) * hotelsPerPage >= hotelViewModel.hotels.count)
                    }
                    .padding()
                }
            }
            .onAppear {
                hotelViewModel.loadHotelDataForCity(for: getCityCode(for: homeViewModel.destination)!)
            }
        }
        .navigationTitle("Travel Me")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HotelListView(homeViewModel: .init(firestoreRepository: .init()), hotelViewModel: .init())
}
