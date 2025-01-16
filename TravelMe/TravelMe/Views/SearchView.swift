//
//  SearchScreen.swift
//  TravelMe
//
//  Created by Noah Ra on 15.01.25.
//

import SwiftUI
import FirebaseCore

struct SearchView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    @State private var searchText = ""
    @State private var selectedLabel = 0
    
    let labels = ["Germany", "Austira", "UK", "Dubai", "Istanbul", "Egypt"]
    
    var body: some View {
        ZStack {
            GradientView()
                .opacity(0.4)
            
            VStack {
                Text("Travel Me")
                    .font(.headline)
                    .padding(.bottom, 8)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(0..<labels.count, id: \.self) { index in
                            Button(action: {
                                selectedLabel = index
                            }) {
                                Text(labels[index])
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(selectedLabel == index ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundStyle(selectedLabel == index ? .white : .black)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Divider()
                
                VStack(spacing: 8) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $searchText)
                    }
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(8)
                    
                    Button("Search") {
                        // Search action
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                
                // Login section
                HStack {
                    if !authViewModel.isRegistering {
                        Button("Sign into your account") {
                            authViewModel.logout()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(0..<10) { _ in
                            VStack {
                                Rectangle()
                                    .fill(.gray.opacity(0.2))
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .overlay(
                                        Text("Musterhotel")
                                            .foregroundStyle(.black)
                                    )
                                    .cornerRadius(8)
                                    .shadow(radius: 2)
                                Text("HotelName")
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
    }
}


#Preview {
    SearchView(homeViewModel: HomeViewModel(firestoreRepository: .init()))
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
