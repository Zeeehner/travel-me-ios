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
// FavoritesViewModel manages the list of favorite hotels for the logged-in user
class FavoritesViewModel: ObservableObject {
    
    // Dependency Injection: Repository for interacting with Firestore
    private let firestoreRepository: FirestoreRepository
    
    // Published property to store the list of favorite hotels, which will trigger UI updates in the view
    @Published var favoriteHotels: [Hotel] = []
    
    // Initializer to inject FirestoreRepository and load favorite hotels for the user
    init(firestoreRepository: FirestoreRepository) {
        self.firestoreRepository = firestoreRepository
        loadFavoriteHotels()  // Load the favorite hotels when the view model is initialized
    }
    
    // Function to load favorite hotels from Firestore for the current logged-in user
    func loadFavoriteHotels() {
        // Get the current user ID from Firebase Authentication
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        // Call the Firestore repository to load favorite hotels and update the view model
        firestoreRepository.loadFavorites(userID: userID) { [weak self] (favorites) in
            self?.favoriteHotels = favorites
        }
    }
    
    // Function to add a hotel to the list of favorite hotels
    func addFavorite(hotel: Hotel) {
        // Check if the hotel is already in the favorites list
        guard !favoriteHotels.contains(where: { $0.id == hotel.id }) else { return }
        
        // Append the hotel to the list of favorite hotels
        favoriteHotels.append(hotel)
        
        // Save the updated list of favorite hotels to Firestore
        saveFavoriteHotels()
    }
    
    // Function to remove a hotel from the list of favorite hotels
    func removeFavorite(hotel: Hotel) {
        // Remove the hotel from the list of favorite hotels
        favoriteHotels.removeAll { $0.id == hotel.id }
        
        // Save the updated list of favorite hotels to Firestore
        saveFavoriteHotels()
    }
    
    // Private function to save the current list of favorite hotels to Firestore
    private func saveFavoriteHotels() {
        // Get the current user ID from Firebase Authentication
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        // Call the Firestore repository to save the favorite hotels for the current user
        firestoreRepository.saveFavorites(userID: userID, favorites: favoriteHotels)
    }
}
