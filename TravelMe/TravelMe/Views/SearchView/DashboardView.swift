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
    
    @State private var isFavorited: Bool = false
    @State private var region: MKCoordinateRegion
    
    init(homeViewModel: HomeViewModel, hotelViewModel: HotelViewModel, selectedIndex: Int) {
        self.homeViewModel = homeViewModel
        self.hotelViewModel = hotelViewModel
        self.selectedIndex = selectedIndex
       
        if selectedIndex < hotelViewModel.hotels.count {
            let hotel = hotelViewModel.hotels[selectedIndex]
            self._region = State(initialValue: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: hotel.geoCode.latitude, longitude: hotel.geoCode.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            ))
        } else {
        
            self._region = State(initialValue: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 52.520008, longitude: 13.404954),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            ))
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientView()
                    .opacity(0.4)
                
                VStack(spacing: 20) {
                    if selectedIndex < hotelViewModel.hotels.count {
                        Text(hotelViewModel.hotels[selectedIndex].name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top)
                    }
                    
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
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(hotelLabels.indices, id: \.self) { index in
                                Button(action: {
                                    homeViewModel.selectedLabel = index
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
                
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your way to us")
                            .font(.headline)
                            .underline()
                            .padding(.horizontal)
                        
                        // Map mit den Markern für Hotels
                        Map(coordinateRegion: $region, annotationItems: hotelViewModel.hotels) { hotel in
                            MapMarker(coordinate: CLLocationCoordinate2D(latitude: hotel.geoCode.latitude, longitude: hotel.geoCode.longitude), tint: .red)
                        }
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                .padding(.top)
            }
            .navigationTitle("Hotel-Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isFavorited.toggle()
                    }) {
                        Image(systemName: isFavorited ? "star.fill" : "star")
                            .foregroundStyle(.yellow)
                    }
                }
            }
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
