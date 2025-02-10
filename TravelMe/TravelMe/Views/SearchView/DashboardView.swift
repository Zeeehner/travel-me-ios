//
//  DashboardView.swift
//  TravelMe
//
//  Created by Noah Ra on 17.01.25.
//

import SwiftUI
import MapKit

struct DashboardView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var hotelViewModel: HotelViewModel
    let selectedIndex: Int
    
    let hotelLabels = ["Arrival", "Information", "Our Team", "Gallery"]
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.520008, longitude: 13.404954),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientView()
                    .opacity(0.4) // Background with slight transparency
                
                VStack(spacing: 20) {
                    // Display the hotel name
                    if selectedIndex < hotelViewModel.hotels.count {
                        Text(hotelViewModel.hotels[selectedIndex].name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top)
                    }
                    
                    // Horizontal scroll for hotel photos
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 16) {
                            ForEach(0..<5, id: \.self) { _ in
                                if selectedIndex < hotelViewModel.hotels.count {
                                    let hotelName = hotelViewModel.hotels[selectedIndex].name
                                    PhotoBox(photoName: hotelName)
                                } else {
                                    PhotoBox(photoName: "defaultPhoto")
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 180)
                    
                    // Horizontal scroll for hotel labels (Arrival, Information, etc.)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(hotelLabels.indices, id: \.self) { index in
                                Button(action: {
                                    homeViewModel.selectedLabel = index // Update the selected label
                                }) {
                                    Text(hotelLabels[index])
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
                    
                    // Map section showing the route to the hotel
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your way to us")
                            .font(.headline)
                            .underline()
                            .padding(.horizontal)
                        
                        Map(coordinateRegion: $region)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal)
                    }
                    
                    Spacer() // Takes up the remaining space
                }
                .padding(.top)
            }
            .navigationTitle("Hotel-Dashboard") // Title of the view
        }
    }
}


#Preview {
    DashboardView(
        homeViewModel: HomeViewModel(firestoreRepository: .init()),
        hotelViewModel: .init(),
        selectedIndex: 0
    )
    .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
