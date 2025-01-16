//
//  BookmarkView.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import SwiftUI
import FirebaseCore

struct BookmarkView: View {
    
    @EnvironmentObject private var authViewModel: AuthViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                GradientView()
                    .opacity(0.4)
                
                VStack(spacing: 0) {
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $homeViewModel.searchText)
                    }
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding()
                    
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
