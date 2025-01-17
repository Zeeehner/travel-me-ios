//
//  Searchbar.swift
//  TravelMe
//
//  Created by Noah Ra on 17.01.25.
//

import SwiftUI

struct Searchbar: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $homeViewModel.searchText)
        }
        .padding()
        .background(.gray.opacity(0.2))
        .cornerRadius(8)
        .padding()
    }
}

#Preview {
    Searchbar(homeViewModel: .init(firestoreRepository: .init()))
}
