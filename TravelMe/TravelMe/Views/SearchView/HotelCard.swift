//
//  HotelCard.swift
//  TravelMe
//
//  Created by Noah Ra on 17.01.25.
//

import SwiftUI

struct HotelCard: View {
    var body: some View {
        Button(action: {
            // placeholder / navigationDestination
        }) {
            VStack {
                Rectangle()
                    .fill(.white.opacity(0.6))
                    .frame(width: 150, height: 110)
                    .aspectRatio(1.0, contentMode: .fit)
                    .overlay(
                        Text("Musterhotel")
                            .foregroundStyle(.black)
                    )
                    .cornerRadius(8)
                    .shadow(radius: 2)
                Text("HotelName")
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    HotelCard()
}
