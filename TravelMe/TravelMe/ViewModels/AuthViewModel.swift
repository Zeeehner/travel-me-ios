//
//  AuthViewModel.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import Foundation
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
    
    private let authRepository: AuthRepository
    private let firestoreRepository: FirestoreRepository
    
    let emailRegEx = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,49}$"
    let genderOptions = ["Male", "Female", "Divers"]
    
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
    
    var currentUserID: String? {
        return user?.uid
    }
    var isLoggedIn: Bool {
        return user != nil
    }
    var errorMessage: String = ""
    var isValidEmail: Bool {
        if email.isEmpty {
            return true
        } else if !email.isEmpty && email.isValid(regexes: [emailRegEx]) {
            return true
        } else {
            return false
        }
    }
    var isRegisterInputValid: Bool {
        if isRegistering {
            return !email.isEmpty && !password.isEmpty && password == confirmPassword && !username.isEmpty && !gender.isEmpty && !adress.isEmpty
        } else {
            return !email.isEmpty && !password.isEmpty
        }
    }
    init(authRepository: AuthRepository, firestoreRepository: FirestoreRepository) {
        self.authRepository = authRepository
        self.firestoreRepository = firestoreRepository
        user = authRepository.auth.currentUser
    }
    func loginAnonymously() async {
        do {
            let result = try await authRepository.loginAnonymously()
            user = result
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert = true
        }
    }
    func loginEmailPassword() async {
        do {
            let result = try await authRepository.signIn(email: email, password: password)
            //            firestoreRepository.loadUser(id: result.uid)
            user = result
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert = true
        }
    }
    func registerEmailPassword() async {
        do {
            let result = try await authRepository.register(email: email, password: password, confirmPassword: confirmPassword, birthday: Date(), gender: gender, adress: adress)
            try firestoreRepository.createUser(id: result.uid, email: email, username: username, gender: gender, birthday: birthday, adress: adress)
            resetUserData()
            isRegistering.toggle()
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert = true
        }
    }
    func resetUserData() {
        self.email = ""
        self.password = ""
        self.confirmPassword = ""
        self.username = ""
        self.birthday = Date()
        self.gender = ""
        self.adress = ""
    }
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
            try await authRepository.auth.sendPasswordReset(withEmail: email)
            errorMessage = "Password reset email sent. Please check your inbox."
            showErrorAlert = true
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert = true
        }
    }
}
