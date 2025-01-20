//
//  SearchBox.swift
//  TravelMe
//
//  Created by Noah Ra on 16.01.25.
//

import SwiftUI

struct SearchBox: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 1) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.black)
                    TextField("Enter your destination", text: $homeViewModel.destination)
                        .textFieldStyle(.plain)
                        .padding(.leading, 5)
                    Spacer()
                }
                .padding()
                .frame(height: 50)
                .background(.white)
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(.red)
                    DatePicker("Select a date", selection: $homeViewModel.travelDate, displayedComponents: .date)
                        .labelsHidden()
                    Spacer()
                }
                .padding()
                .frame(height: 50)
                .background(.white)
                
                HStack {
                    Image(systemName: "person.2")
                        .foregroundStyle(.green)
                    Text("Number of guests?")
                        .foregroundStyle(.gray.opacity(0.6))
                    Picker("Passengers", selection: $homeViewModel.numberOfPassengers) {
                        ForEach(1...9, id: \.self) { pers in
                            Text("\(pers)")
                        }
                    }
                    .padding(.leading, 90)
                    .pickerStyle(.menu)
                    Spacer()
                }
                .padding()
                .frame(height: 50)
                .background(.white)
                
                Button(action: {
                    // placeholder
                }) {
                    Text("Search")
                        .bold()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                }
                .frame(height: 50)
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1)
                    .opacity(0.3)
                    .shadow(radius: 2)
            )
            .padding()
        }
    }
}


#Preview {
    ZStack {
        Color.black
        SearchBox(homeViewModel: .init(firestoreRepository: .init()))
    }
}
