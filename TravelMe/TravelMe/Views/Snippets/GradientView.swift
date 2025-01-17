//
//  GradientView.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import SwiftUI

struct GradientView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.36, green: 0.74, blue: 0.60),
                Color(red: 0.32, green: 0.60, blue: 0.87),
                Color(red: 0.85, green: 0.93, blue: 0.87)  
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    GradientView()
}
