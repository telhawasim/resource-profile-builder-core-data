//
//  UserSettings.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 02/11/2023.
//

import Foundation
import UIKit

class UserSettings {

    static let shared = UserSettings()

    private init() {}

    private let emailKey = "UserEmail"
    private let passwordKey = "UserPassword"

    var userEmail: String? {
        get {
            return UserDefaults.standard.string(forKey: emailKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: emailKey)
        }
    }

    var userPassword: String? {
        get {
            return UserDefaults.standard.string(forKey: passwordKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: passwordKey)
        }
    }

    func clearUserCredentials() {
        UserDefaults.standard.removeObject(forKey: emailKey)
        UserDefaults.standard.removeObject(forKey: passwordKey)
    }
    
    func isAdminLoggedIn() -> Bool {
        return userEmail != nil && userPassword != nil
    }
}
