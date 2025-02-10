//
//  AuthRepository.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import Foundation
import FirebaseAuth

/// AuthRepository handles user authentication using Firebase Authentication.
class AuthRepository {
    
    /// Firebase authentication instance.
    let auth = Auth.auth()
    
    /// Logs in a user anonymously.
    /// - Returns: A FirebaseAuth.User instance if successful.
    func loginAnonymously() async throws -> FirebaseAuth.User {
        do {
            let result = try await auth.signInAnonymously()
            return result.user
        } catch {
            print(error)
            throw error
        }
    }
    
    /// Registers a new user with email and password.
    /// - Parameters:
    ///   - email: The user's email address.
    ///   - password: The user's chosen password.
    ///   - confirmPassword: The password confirmation (not used in Firebase request but useful for validation).
    ///   - birthday: The user's birth date.
    ///   - gender: The user's gender.
    ///   - address: The user's address.
    /// - Returns: A FirebaseAuth.User instance if successful.
    func register(email: String, password: String, confirmPassword: String, birthday: Date, gender: String, adress: String) async throws -> FirebaseAuth.User {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            return result.user
        } catch {
            print(error)
            throw error
        }
    }
    
    /// Signs in a user with email and password.
    /// - Parameters:
    ///   - email: The user's email address.
    ///   - password: The user's password.
    /// - Returns: A FirebaseAuth.User instance if successful.
    func signIn(email: String, password: String) async throws -> FirebaseAuth.User {
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            return result.user
        } catch {
            print(error)
            throw error
        }
    }
    
    /// Logs out the currently signed-in user.
    func logout() throws {
        do {
            try auth.signOut()
        } catch {
            print(error)
            throw error
        }
    }
}
