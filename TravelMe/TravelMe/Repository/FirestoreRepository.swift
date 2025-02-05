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
}
