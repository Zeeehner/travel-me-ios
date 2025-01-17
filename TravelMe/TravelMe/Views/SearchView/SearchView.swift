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
    
    let labels = ["Germany", "Austria", "UK", "Dubai", "Istanbul", "Egypt"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientView()
                    .opacity(0.4)
                
                VStack(spacing: 16) {
                    Text("Travel Me")
                        .font(.headline)
                        .padding(.bottom, 8)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(0..<labels.count, id: \.self) { index in
                                Button(action: {
                                    homeViewModel.selectedLabel = index
                                }) {
                                    Text(labels[index])
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(homeViewModel.selectedLabel == index ? Color.blue : Color.white.opacity(0.8))
                                        .foregroundStyle(homeViewModel.selectedLabel == index ? .white : .black)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 40)
                    
                    Divider()
                    
                    SearchBox(homeViewModel: homeViewModel)
                    
                    Divider()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading) {
                                Text("Featured Hotels")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 16) {
                                        ForEach(0..<10, id: \.self) { index in
                                            HotelCard()
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            
                            Divider()
                            
                            VStack(alignment: .leading) {
                                Text("All Hotels")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                LazyVGrid(columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ], spacing: 16) {
                                    ForEach(0..<10, id: \.self) { _ in
                                        HotelCard()
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    SearchView(homeViewModel: HomeViewModel(firestoreRepository: .init()))
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
