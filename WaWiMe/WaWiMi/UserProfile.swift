//
//  UserProfile.swift
//  WaWiMi
//
//  Created by ashley ryf-pallister on 5/5/25.
//

import Foundation

struct UserProfile: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let bio: String
    let photo: String
}
