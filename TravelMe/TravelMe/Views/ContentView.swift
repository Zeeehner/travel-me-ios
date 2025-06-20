//
//  ContentView.swift
//  TravelMe
//
//  Created by Noah Ra on 17.01.25.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseCrashlytics


struct ContentView: View {
    
    @EnvironmentObject private var authViewModel : AuthViewModel
    @ObservedObject var homeViewModel : HomeViewModel
    @ObservedObject var hotelViewModel: HotelViewModel
    
    var body: some View {
        if authViewModel.isLoggedIn {
            MainTabView(homeViewModel: homeViewModel, hotelViewModel: hotelViewModel)
        } else {
            LoginView(homeViewModel: homeViewModel)
        }
    }
}

#Preview {
    ContentView(homeViewModel: HomeViewModel(firestoreRepository: .init()), hotelViewModel: .init())
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
