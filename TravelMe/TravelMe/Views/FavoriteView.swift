//
//  FavoriteView.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import SwiftUI
import FirebaseCore

struct FavoriteView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientView()
                    .opacity(0.4)
                
                VStack(spacing: 0) {                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $searchText)
                    }
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding()
                    
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(0..<4) { _ in
                                VStack {
                                    Rectangle()
                                        .fill(.gray.opacity(0.2))
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .overlay(
                                            Text("Musterhotel / Liked")
                                                .foregroundStyle(.black)
                                        )
                                        .cornerRadius(8)
                                        .shadow(radius: 2)
                                }
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Favorites")
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    FavoriteView(homeViewModel: HomeViewModel(firestoreRepository: .init()))
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
