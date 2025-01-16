//
//  BookingCell.swift
//  TravelMe
//
//  Created by Noah Ra on 16.01.25.
//

import SwiftUI

struct BookingCell: View {
    var body: some View {
        HStack(spacing: 0) {
            // Image section
            Rectangle()
                .fill(.gray.opacity(0.2))
                .frame(width: 100, height: 100)
                .overlay(
                    Image(systemName: "photo")
                        .foregroundStyle(.gray)
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Hotel Musterhaus")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 2)
                
                Text("Booked at: 15. Januar 2025")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 2)
                    .padding(.trailing, 40)
            }
            .padding()
        }
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
#Preview {
    BookingCell()
}
