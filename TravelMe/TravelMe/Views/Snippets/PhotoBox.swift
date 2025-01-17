//
//  PhotoBox.swift
//  TravelMe
//
//  Created by Noah Ra on 17.01.25.
//

import SwiftUI

struct PhotoBox: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(.white.opacity(0.6))
                .frame(width: 150, height: 110)
                .aspectRatio(1.0, contentMode: .fit)
                .overlay(
                    Text("Photo")
                        .foregroundStyle(.black)
                )
                .cornerRadius(8)
                .shadow(radius: 2)
        }
    }
}

#Preview {
    PhotoBox()
}
