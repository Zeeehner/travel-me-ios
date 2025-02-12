//
//  PhotoBox.swift
//  TravelMe
//
//  Created by Noah Ra on 17.01.25.
//

import SwiftUI

struct PhotoBox: View {
    @StateObject private var viewModel = PhotoBoxImageViewModel() 
    let photoName: String // Name des Fotos, das geladen werden soll

    var body: some View {
        VStack {
            if !viewModel.imageUrl.isEmpty {
                AsyncImage(url: URL(string: viewModel.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 110)
                .cornerRadius(8)
                .shadow(radius: 2)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchImage(photoName: photoName)
            }
        }
    }
}

#Preview {
    PhotoBox(photoName: "Döner")
}
