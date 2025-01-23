//
//  MainTabView.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import SwiftUI
import FirebaseCore

struct MainTabView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    @ObservedObject var hotelViewModel: HotelViewModel
    
    
    var body: some View {
            TabView {
                
                SearchView(homeViewModel: homeViewModel, hotelViewModel: hotelViewModel)
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                FavoriteView(homeViewModel: homeViewModel, hotelViewModel: hotelViewModel)
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
                
                BookmarkView(homeViewModel: homeViewModel)
                    .tabItem {
                        Label("Bookmarks", systemImage: "bookmark")
                    }
                
                ProfileView(homeViewModel: homeViewModel)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
            .environmentObject(authViewModel)
            .environmentObject(homeViewModel)
    }
}

#Preview {
    MainTabView(homeViewModel: HomeViewModel(firestoreRepository: .init()), hotelViewModel: .init())
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
