//
//  HotelOffersView.swift
//  TravelMe
//
//  Created by Noah Ra on 23.01.25.
//

import SwiftUI

struct HotelOffersView: View {
    
    @State private var hotelOffers: [Datum] = []

    var body: some View {
        VStack {
            if !hotelOffers.isEmpty {
                List(hotelOffers) { offer in
                    Text(offer.hotel.name)
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            fetchHotelOffers()
        }
    }

    private func fetchHotelOffers() {
        let accessToken = "Bearer xGCLsiMU5XWR2RN8l1HlMO9sb6pw"
        let url = URL(string: "https://test.api.amadeus.com/v3/shopping/hotel-offers?hotelIds=MCLONGHM&adults=1")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let welcome = try JSONDecoder().decode(Welcome.self, from: data)
                    DispatchQueue.main.async {
                        self.hotelOffers = welcome.data
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Error fetching hotel offers: \(error)")
            }
        }
        .resume()
    }
}

#Preview {
    HotelOffersView()
}
