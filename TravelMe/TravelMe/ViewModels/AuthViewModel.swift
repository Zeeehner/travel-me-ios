//
//  AuthViewModel.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import Foundation
import FirebaseAuth

@MainActor
// AuthViewModel is the ViewModel responsible for handling user authentication logic
class AuthViewModel: ObservableObject {
    
    // Dependency Injection for repositories that handle auth and firestore operations
    private let authRepository: AuthRepository
    private let firestoreRepository: FirestoreRepository
    
    // Regular expression pattern for validating email format
    let emailRegEx = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,49}$"
    // Gender options available for the user
    let genderOptions = ["Male", "Female", "Divers"]
    
    // Published properties that will trigger UI updates in the View
    @Published var user: FirebaseAuth.User?
    @Published var isRegistering = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword = ""
    @Published var username: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var birthday = Date()
    @Published var gender = ""
    @Published var showErrorAlert: Bool = false
    @Published var showDeleteAlert = false
    @Published var adress = ""
    @Published var number = ""
    @Published var shareLocation = false
    @Published var enableNotifications = false
    @Published var subscribeNewsletter = false
    
    // Computed property that returns the current user's ID
    var currentUserID: String? {
        return user?.uid
    }
    
    // Computed property that checks if the user is logged in
    var isLoggedIn: Bool {
        return user != nil
    }
    
    // Error message to display in case of an error
    var errorMessage: String = ""
    
    // Computed property to check if the entered email is valid using the regex pattern
    var isValidEmail: Bool {
        if email.isEmpty {
            return true
        } else if !email.isEmpty && email.isValid(regexes: [emailRegEx]) {
            return true
        } else {
            return false
        }
    }
    
    // Computed property to check if the input data for registration is valid
    var isRegisterInputValid: Bool {
        if isRegistering {
            return !email.isEmpty && !password.isEmpty && password == confirmPassword && !username.isEmpty && !gender.isEmpty && !adress.isEmpty
        } else {
            return !email.isEmpty && !password.isEmpty
        }
    }
    
    // Initializer to inject the dependencies (authRepository and firestoreRepository)
    init(authRepository: AuthRepository, firestoreRepository: FirestoreRepository) {
        self.authRepository = authRepository
        self.firestoreRepository = firestoreRepository
        user = authRepository.auth.currentUser
    }
    
    // Function to log the user in anonymously
    func loginAnonymously() async {
        do {
            let result = try await authRepository.loginAnonymously()
            user = result
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert = true
        }
    }
    
    // Function to log the user in using email and password
    func loginEmailPassword() async {
        do {
            let result = try await authRepository.signIn(email: email, password: password)
            // Optionally, load additional user data from Firestore here
            user = result
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert = true
        }
    }
    
    // Function to register a new user with email and password
    func registerEmailPassword() async {
        do {
            // Register the user with the provided credentials
            let result = try await authRepository.register(email: email, password: password, confirmPassword: confirmPassword, birthday: Date(), gender: gender, adress: adress)
            // Create the user's document in Firestore with additional info
            try firestoreRepository.createUser(id: result.uid, email: email, username: username, gender: gender, birthday: birthday, adress: adress)
            // Reset user data after registration
            resetUserData()
            isRegistering.toggle()
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert = true
        }
    }
    
    // Function to reset user input data fields
    func resetUserData() {
        self.email = ""
        self.password = ""
        self.confirmPassword = ""
        self.username = ""
        self.birthday = Date()
        self.gender = ""
        self.adress = ""
    }
    
    // Function to log out the current user
    func logout() {
        do {
            try authRepository.logout()
            resetUserData()
            user = authRepository.auth.currentUser
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert = true
        }
    }
    
    // Function to send a password reset email to the user
    func resetPassword() async {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email address."
            showErrorAlert = true
            return
        }
        
        guard isValidEmail else {
            errorMessage = "Please enter a valid email address."
            showErrorAlert = true
            return
        }
        
        do {
            // Send password reset email
            try await authRepository.auth.sendPasswordReset(withEmail: email)
            errorMessage = "Password reset email sent. Please check your inbox."
            showErrorAlert = true
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert = true
        }
    }
}
