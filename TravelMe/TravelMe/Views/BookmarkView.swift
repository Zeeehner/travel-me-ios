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
        ZStack {
            GradientView()
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    BookmarkView(homeViewModel: HomeViewModel(firestoreRepository: .init()))
        .environmentObject(AuthViewModel(authRepository: .init(), firestoreRepository: .init()))
}
