//
//  TravelMeApp.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import SwiftUI
import SwiftData
import FirebaseAuth
import FirebaseCore
import FirebaseCrashlytics

@main
struct TravelMeApp: App {
    
    @StateObject private var authViewModel = AuthViewModel(authRepository: .init(), firestoreRepository: .init())
    @StateObject private var homeViewModel = HomeViewModel(firestoreRepository: .init())
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        print("Firebase loading complete!")
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            LoginView(homeViewModel: homeViewModel)
        }
        .environmentObject(authViewModel)
        .modelContainer(sharedModelContainer)
    }
}
