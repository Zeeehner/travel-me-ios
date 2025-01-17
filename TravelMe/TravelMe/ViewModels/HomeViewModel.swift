//
//  HomeViewModel.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import Foundation
import FirebaseFirestore

@MainActor
class HomeViewModel: ObservableObject {
    
    private let firestoreRepository: FirestoreRepository
    
    @Published var appUser: AppUser?
    @Published var showErrorAlert: Bool = false
    @Published var showCreateSheet: Bool = false
    @Published var searchText = ""
    @Published var selectedLabel = 0
    @Published var destination: String = ""
    @Published var travelDate: Date = Date()
    @Published var numberOfPassengers: Int = 1
    @Published private var likedItems: [Int] = []
    
    var errorMessage: String = ""
    var listener: ListenerRegistration?
    
    init(firestoreRepository: FirestoreRepository) {
        self.firestoreRepository = firestoreRepository
    }
    deinit {
        listener?.remove()
    }
    
    func loadUser(uid: String) async {
        do {
            appUser = try await firestoreRepository.loadUser(id: uid)
        } catch {
            errorMessage = error.localizedDescription
            showErrorAlert = true
        }
    }
}
