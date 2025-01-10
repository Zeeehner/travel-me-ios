//
//  MainTabView.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var homeViewModel : HomeViewModel
    
    var body: some View {
            TabView {
                
                DashboardView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
    }
}

#Preview {
    MainTabView(homeViewModel: HomeViewModel(firestoreRepository: .init()))
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
