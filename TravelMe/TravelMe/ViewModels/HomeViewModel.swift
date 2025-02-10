//
//  HomeViewModel.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import Foundation
import FirebaseFirestore

@MainActor
// HomeViewModel is responsible for managing the data and actions on the home screen
class HomeViewModel: ObservableObject {
    
    // Dependency Injection: Repository for interacting with Firestore
    private let firestoreRepository: FirestoreRepository
    
    // Published properties to trigger UI updates when the data changes
    @Published var appUser: AppUser?
    @Published var showErrorAlert: Bool = false
    @Published var showCreateSheet: Bool = false
    @Published var searchText = ""
    @Published var selectedLabel = 0
    @Published var destination: String = ""
    @Published var travelDate: Date = Date()
    @Published var numberOfPassengers: Int = 1
    @Published private var likedItems: [Int] = [] // Stores liked items (private to prevent direct access)
    
    // Error message to display in case of an error
    var errorMessage: String = ""
    
    // Listener to track Firestore updates (if needed)
    var listener: ListenerRegistration?
    
    // Initializer to inject the FirestoreRepository for data fetching
    init(firestoreRepository: FirestoreRepository) {
        self.firestoreRepository = firestoreRepository
    }
    
    // Deinitializer to remove the listener when the view model is deallocated
    deinit {
        listener?.remove()
    }
    
    // Function to load the user details from Firestore using the user's ID
    func loadUser(uid: String) async {
        do {
            // Fetch user data from Firestore and assign it to appUser
            appUser = try await firestoreRepository.loadUser(id: uid)
        } catch {
            // Handle any error that occurs during the data fetching process
            errorMessage = error.localizedDescription
            showErrorAlert = true
        }
    }
}
