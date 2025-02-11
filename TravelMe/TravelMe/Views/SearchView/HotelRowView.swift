//
//  HotelRowView.swift
//  TravelMe
//
//  Created by Noah Ra on 11.02.25.
//

import SwiftUI

struct HotelRowView: View {
    
    let hotel: Hotel
    
    var body: some View {
        HStack {
            HotelImageView(hotelName: hotel.name)
                .frame(width: 100, height: 80)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(hotel.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text(hotel.iataCode)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                HStack {
                    if let distance = hotel.distance?.value {
                        Text("📍 \(distance, specifier: "%.1f") km away")
                    }
                    Spacer()
                    Text("ID: \(hotel.hotelId)")
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)
                }
                .font(.subheadline)
            }
            .padding(.leading, 8)
            
            Spacer()
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

