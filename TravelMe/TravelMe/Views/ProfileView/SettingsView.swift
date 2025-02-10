//
//  SettingsView.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            GradientView()
                .opacity(0.4) // Background with slight transparency
            
            VStack(spacing: 20) {
                Text("Settings") // Page title
                    .font(.title)
                    .bold()
                    .padding()
                
                // Settings section for location sharing and notifications
                VStack(spacing: 0) {
                    // Toggle for location sharing
                    HStack {
                        Text("Share location")
                        Spacer()
                        Toggle("Share location", isOn: $authViewModel.shareLocation)
                            .labelsHidden()
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                    
                    // Toggle for enabling notifications
                    HStack {
                        Text("Enable Notifications")
                        Spacer()
                        Toggle("Enable Notifications", isOn: $authViewModel.enableNotifications)
                            .labelsHidden()
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                    
                    // Newsletter subscription settings
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Newsletter")
                            Spacer()
                            Toggle("Subscribe to Newsletter", isOn: $authViewModel.subscribeNewsletter)
                                .labelsHidden()
                        }
                        Text("Subscribe to the free newsletter and stay up to date!")
                            .font(.caption)
                            .fontWeight(.thin)
                    }
                    .padding(.vertical, 8)
                }
                .padding()
                .background(.white.opacity(0.6)) // Background with slight transparency
                .cornerRadius(8)
                .padding(.horizontal)
                
                // General settings title
                Text("General")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                // Buttons for general settings
                VStack(spacing: 10) {
                    // Placeholder for editing the profile
                    Button(action: {
                        // placeholder
                    }) {
                        Text("Edit your Profile")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.white.opacity(0.6))
                            .cornerRadius(8)
                    }
                    
                    // Placeholder for CarPlay settings
                    Button(action: {
                        // placeholder
                    }) {
                        Text("CarPlay")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.white.opacity(0.6))
                            .cornerRadius(8)
                    }
                    
                    // Placeholder for tracking settings
                    Button(action: {
                        // placeholder
                    }) {
                        Text("Tracking")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.white.opacity(0.6))
                            .cornerRadius(8)
                    }
    
                    // Logout button
                    Button(action: {
                        authViewModel.logout() // Log out the user
                        homeViewModel.appUser = nil // Remove user from HomeViewModel
                    }) {
                        Text("Logout")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(.red)
                            .background(.white.opacity(0.6))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                // Terms of Service and Privacy Policy notice
                VStack(alignment: .center){
                    Text("By signing in to your account or creating a new one, you agree to our Terms of Service and Privacy Policy.")
                        .lineLimit(2)
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }

                Spacer() // Uses the remaining space
            }
        }
    }
}

#Preview {
    SettingsView(homeViewModel: HomeViewModel(firestoreRepository: .init()))
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
