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
class UserSaveData: Codable, Initiable {
    static let path = "UserSaveData.json"

    // var isLoggedIn: LoginType = .notLogin
    
    required init() {
    }
    
    public class var sharemanager: UserSaveData {
        struct Instance {
            static let singleInstance = UserSaveData.load()
        }
        return Instance.singleInstance
    }
    
    func save() {
        FileSave.save(self, UserSaveData.path)
    }

    // fileprivate since i want to sharedmanger
    fileprivate static func load() -> UserSaveData {
        let _sharedmanager: UserSaveData = FileSave.load(UserSaveData.path)
        return _sharedmanager
    }
}
