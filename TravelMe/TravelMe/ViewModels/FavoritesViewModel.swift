//
//  FavoritesViewModel.swift
//  TravelMe
//
//  Created by Noah Ra on 31.01.25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
class FavoritesViewModel: ObservableObject {
    
    private let firestoreRepository: FirestoreRepository
    @Published var favoriteHotels: [Hotel] = []
    
    init(firestoreRepository: FirestoreRepository) {
        self.firestoreRepository = firestoreRepository
        loadFavoriteHotels()
    }
    
    func loadFavoriteHotels() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        firestoreRepository.loadFavorites(userID: userID) { [weak self] (favorites) in
            self?.favoriteHotels = favorites
        }
    }
    
    func addFavorite(hotel: Hotel) {
        guard !favoriteHotels.contains(where: { $0.id == hotel.id }) else { return }
        favoriteHotels.append(hotel)
        saveFavoriteHotels()
    }
    
    func removeFavorite(hotel: Hotel) {
        favoriteHotels.removeAll { $0.id == hotel.id }
        saveFavoriteHotels()
    }
    
    private func saveFavoriteHotels() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        firestoreRepository.saveFavorites(userID: userID, favorites: favoriteHotels)
    }
}
