//
//  Authentication.swift
//  sampleBiometric
//
//  Created by ramirez on 2024/07/31.
//

import Foundation
import LocalAuthentication

class Authentication {
    
    func getAuthenticationType() -> LABiometryType {
        let context = LAContext()
        return context.biometryType
    }
    
    func canEvaluateAuthentication() -> Bool {
        let context = LAContext()
        var error: NSError?
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }
    
    func registerAuthentictaion() {
        
    }
    
    
}
