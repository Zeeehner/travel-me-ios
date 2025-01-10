//
//  AppUser.swift
//  TravelMe
//
//  Created by Noah Ra on 10.01.25.
//

import Foundation
import FirebaseFirestore
import FirebaseCore

struct AppUser: Codable {
    var id: String
    var username: String
    var email: String
    var gender: String
    var registeredOn: String
    var birthday: Date
    
    var age: Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: Date())
        return ageComponents.year ?? 0
    }
    
    init(id: String, username: String, email: String, gender: String, registeredOn: String = Date.now.ISO8601Format(), birthday: Date) {
        self.id = id
        self.username = username
        self.email = email
        self.gender = gender
        self.registeredOn = registeredOn
        self.birthday = birthday
    }
}
