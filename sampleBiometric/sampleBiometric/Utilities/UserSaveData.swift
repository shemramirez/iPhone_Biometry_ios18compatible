//
//  UserSaveData.swift
//  sampleBiometric
//
//  Created by ramirez on 2024/08/07.
//

import Foundation

enum LoginType {
    case login
    case notLogin
}

// TODO: Save Data
class UserSaveData: Codable {
    static let path = "UserSaveData.json"

    // var isLoggedIn: LoginType = .notLogin
    
}
