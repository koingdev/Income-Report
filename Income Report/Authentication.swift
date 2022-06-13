//
//  Authentication.swift
//  Income Report
//
//  Created by KoingDev on 13/6/22.
//

import Foundation
import LocalAuthentication

struct Authentication {
    static func start() async -> Bool {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Please unlock your device to use the feature."
            return await withCheckedContinuation { continuation in
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                    debugPrint(authenticationError?.localizedDescription ?? "Authenticate success.")
                    continuation.resume(returning: success)
                }
            }
        } else {
            debugPrint("Cannot evaluate policy!")
            return false
        }
    }
}
