//
//  ProfileView.swift
//  TravelMe
//
//  Created by Noah Ra on 15.01.25.
//

import SwiftUI
import MapKit

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.5200, longitude: 13.4050),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    
    @State private var hotels = Hotels.samples
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient background with opacity for styling
                GradientView()
                    .opacity(0.4)
                
                VStack(spacing: 30) {
                    // User profile section: displays user's name, email, and address
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            // Displaying the username from the homeViewModel (fallback text if not available)
                            Text(homeViewModel.appUser?.username ?? "User not logged in")
                                .font(.headline)
                            
                            // Displaying email and address, with fallbacks
                            Text(homeViewModel.appUser?.email ?? "")
                            Text(homeViewModel.appUser?.adress ?? "No further information")
                                .fontWeight(.thin)
                        }
                        
                        Spacer()
                        
                        // Default profile picture icon
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .padding()
                    .background(.white.opacity(0.6)) // White background with slight opacity
                    .cornerRadius(8) // Rounded corners for the profile section
                    .padding(.horizontal)
                    
                    // Divider to separate sections visually
                    Divider()
                    
                    // Section title for "Nearby Hotels"
                    Text("Nearby Hotels")
                        .font(.title)
                        .bold()
                        .italic()
                        .underline()
                        .frame(alignment: .center)
                        .padding(.horizontal)
                    
                    // Map view that displays nearby hotels using MapKit
                    Map(coordinateRegion: $region, annotationItems: hotels) { hotel in
                        // Place a red marker for each hotel on the map
                        MapMarker(coordinate: hotel.coordinate, tint: .red)
                    }
                    .frame(height: 300) // Set height of the map
                    .cornerRadius(8) // Rounded corners for the map view
                    .padding(.horizontal)
                    
                    // Text describing the importance of safe driving
                    Text("Drive safe during navigation")
                        .padding()
                        .frame(maxWidth: .infinity) // Full-width frame
                        .background(.white.opacity(0.6)) // Background with slight opacity
                        .cornerRadius(8) // Rounded corners
                        .padding(.horizontal)
                    
                    Spacer() // Pushes all content upwards
                }
                .task {
                    // Fetch the user data from the home view model when the view appears
                    if let uid = authViewModel.currentUserID {
                        await homeViewModel.loadUser(uid: uid)
                    }
                }
            }
            .navigationTitle("Profile") // Set navigation bar title
            .toolbar {
                // Gear icon in the navigation bar to navigate to settings
                ToolbarItem {
                    NavigationLink(destination: SettingsView(homeViewModel: homeViewModel)) {
                        Image(systemName: "gear")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}


#Preview {
    ProfileView(homeViewModel: HomeViewModel(firestoreRepository: .init()))
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
