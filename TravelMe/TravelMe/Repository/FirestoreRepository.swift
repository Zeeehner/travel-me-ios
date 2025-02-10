//
//  FirestoreRepository.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import Foundation
import FirebaseFirestore

/// FirestoreRepository handles user data storage and retrieval in Firestore.
class FirestoreRepository {
    
    /// Firestore database instance.
    let db = Firestore.firestore()
    
    /// Creates a new user document in Firestore.
    /// - Parameters:
    ///   - id: The user's unique identifier.
    ///   - email: The user's email address.
    ///   - username: The user's chosen username.
    ///   - gender: The user's gender.
    ///   - birthday: The user's birth date.
    ///   - address: The user's address.
    func createUser(id: String, email: String, username: String, gender: String, birthday: Date, adress: String) throws {
        let user: AppUser = .init(id: id, username: username, email: email, gender: gender, registeredOn: Date.now.ISO8601Format(), birthday: birthday, adress: adress)
        do {
            try db.collection("users").document(id).setData(from: user)
        } catch {
            print(error)
            throw error
        }
    }
    
    /// Loads a user's data from Firestore.
    /// - Parameter id: The user's unique identifier.
    /// - Returns: An instance of `AppUser` if successful.
    func loadUser(id: String) async throws -> AppUser {
        do {
            let result = try await db.collection("users").document(id).getDocument()
            return try result.data(as: AppUser.self)
        } catch {
            print(error)
            throw error
        }
    }
    
    /// Loads a user's favorite hotels from Firestore.
    /// - Parameters:
    ///   - userID: The user's unique identifier.
    ///   - completion: A closure returning an array of `Hotel` instances.
    func loadFavorites(userID: String, completion: @escaping ([Hotel]) -> Void) {
        db.collection("users").document(userID).collection("favorites")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error loading favorites: \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                let hotels = snapshot?.documents.compactMap { document in
                    try? document.data(as: Hotel.self)
                } ?? []
                
                completion(hotels)
            }
    }
    
    /// Saves a user's favorite hotels to Firestore.
    /// - Parameters:
    ///   - userID: The user's unique identifier.
    ///   - favorites: An array of `Hotel` instances to be saved.
    func saveFavorites(userID: String, favorites: [Hotel]) {
        let favoritesRef = db.collection("users").document(userID).collection("favorites")
        favoritesRef.getDocuments { snapshot, error in
            snapshot?.documents.forEach { document in
                document.reference.delete()
            }
            
            for hotel in favorites {
                do {
                    try favoritesRef.addDocument(from: hotel)
                } catch {
                    print("Error saving favorite hotel: \(error.localizedDescription)")
                }
            }
        }
    }
}
