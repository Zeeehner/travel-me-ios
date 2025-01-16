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
                .opacity(0.4)
            
            VStack(spacing: 20) {
                Text("Settings")
                    .font(.title)
                    .padding()
                
                VStack(spacing: 0) {
                    HStack {
                        Text("Share location")
                        Spacer()
                        Toggle("Share location", isOn: $authViewModel.shareLocation)
                            .labelsHidden()
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                    
                    HStack {
                        Text("Enable Notifications")
                        Spacer()
                        Toggle("Enable Notifications", isOn: $authViewModel.enableNotifications)
                            .labelsHidden()
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                    
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
//                .background(.gray.opacity(0.2))
                .background(.white.opacity(0.6))
                .cornerRadius(8)
                .padding(.horizontal)
                
                Text("General")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                VStack(spacing: 12) {
                    Button(action: {
                        // placeholder
                    }) {
                        Text("Edit your Profile")
                            .frame(maxWidth: .infinity)
                            .padding()
//                            .background(.gray.opacity(0.2))
                            .background(.white.opacity(0.6))
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        // placeholder
                    }) {
                        Text("CarPlay")
                            .frame(maxWidth: .infinity)
                            .padding()
//                            .background(.gray.opacity(0.2))
                            .background(.white.opacity(0.6))
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        // placeholder
                    }) {
                        Text("Tracking")
                            .frame(maxWidth: .infinity)
                            .padding()
//                            .background(.gray.opacity(0.2))
                            .background(.white.opacity(0.6))
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        authViewModel.logout()
                        homeViewModel.appUser = nil
                    }) {
                        Text("Logout")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(.red)
//                            .background(.gray.opacity(0.2))
                            .background(.white.opacity(0.6))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                Spacer ()
                
                Text("By signing in to your account or creating a new one, you agree to our Terms of Service and Privacy Policy.")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsView(homeViewModel: HomeViewModel(firestoreRepository: .init()))
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
