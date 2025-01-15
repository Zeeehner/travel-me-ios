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
    
    
    @State private var hotels = Hotel.samples
    
    var body: some View {
        ZStack {
            GradientView()
                .opacity(0.4)
            
            VStack(spacing: 16) {
                Text("Profile")
                    .font(.headline)
                    .padding(.bottom, 8)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(homeViewModel.appUser?.username ?? "User not logged in")
                            .font(.headline)
                        Text(homeViewModel.appUser?.email ?? "")
                        Text(homeViewModel.appUser?.adress ?? "No further information")
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
                
                
                Text("Nearby Hotels")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                
                
                Map(coordinateRegion: $region, annotationItems: hotels) { hotel in
                    MapMarker(coordinate: hotel.coordinate, tint: .red)
                }
                .frame(height: 300)
                .cornerRadius(8)
                .padding(.horizontal)
                
                
                Text("Drive save during navigation")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Button("Logout") {
                    authViewModel.logout()
                }
                .padding()
                .buttonStyle(.borderedProminent)
                Spacer()
                
            }
            
            .task {
                if let uid = authViewModel.currentUserID {
                    await homeViewModel.loadUser(uid: uid)
                }
            }
        }
    }
}

    #Preview {
        ProfileView(homeViewModel: HomeViewModel(firestoreRepository: .init()))
            .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
    }
