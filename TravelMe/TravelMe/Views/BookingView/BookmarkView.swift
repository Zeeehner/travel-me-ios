//
//  BookmarkView.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import SwiftUI
import FirebaseCore

// BookmarkView displays a list of bookings with a search bar and a gradient background
struct BookmarkView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientView()
                    .opacity(0.4)
                
                VStack(spacing: 0) {
                    
                    // Searchbar placed at the top to allow searching for bookings
                    Searchbar(homeViewModel: homeViewModel)
                    
                    // LazyVStack to display a vertically scrolling list of items with dynamic data
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(0..<4) { _ in
                                BookingCell()
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Bookings")
        }
    }
}

#Preview {
    BookmarkView(homeViewModel: HomeViewModel(firestoreRepository: .init()))
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
