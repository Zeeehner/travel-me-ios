//
//  FirestoreRepository.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import Foundation
import FirebaseFirestore

class FirestoreRepository {
    
    let db = Firestore.firestore()
    
    func createUser(id: String, email: String, username: String, gender: String, birthday: Date, adress: String) throws {
        let user: AppUser = .init(id: id, username: username, email: email, gender: gender, registeredOn: Date.now.ISO8601Format(), birthday: birthday, adress: adress)
        do {
            try db.collection("users").document(id).setData(from: user)
        } catch {
            print(error)
            throw error
        }
    }
    
    func loadUser(id: String) async throws -> AppUser {
        do {
            let result = try await db.collection("users").document(id).getDocument()
            return try result.data(as: AppUser.self)
        } catch {
            print(error)
            throw error
        }
    }
    
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
