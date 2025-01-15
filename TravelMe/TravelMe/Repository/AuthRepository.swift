//
//  AuthRepository.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import Foundation
import FirebaseAuth

class AuthRepository {
    
    let auth = Auth.auth()
    
    func loginAnonymously() async throws -> FirebaseAuth.User {
        do {
            let result = try await auth.signInAnonymously()
            return result.user
        } catch {
            print(error)
            throw error
        }
    }
    func register(email: String, password: String, confirmPassword: String, birthday: Date, gender: String, adress: String) async throws -> FirebaseAuth.User {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            return result.user
        } catch {
            print(error)
            throw error
        }
    }
    func signIn(email: String, password: String) async throws -> FirebaseAuth.User {
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            return result.user
        } catch {
            print(error)
            throw error
        }
    }
    func logout() throws {
        do {
            try auth.signOut()
        } catch {
            print(error)
            throw error
        }
    }
}
