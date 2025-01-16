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
                                homeViewModel.selectedLabel = index
                            }) {
                                Text(labels[index])
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(homeViewModel.selectedLabel == index ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundStyle(homeViewModel.selectedLabel == index ? .white : .black)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Divider()
                
                SearchBox(homeViewModel: homeViewModel)
                
               
                Divider()
                
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(0..<10) { _ in
                            VStack {
                                Rectangle()
//                                    .fill(.gray.opacity(0.2))
                                    .fill(.white.opacity(0.6))
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
