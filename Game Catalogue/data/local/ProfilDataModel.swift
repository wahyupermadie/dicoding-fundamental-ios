//
//  ProfilDataModel.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 19/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation

struct ProfilDataModel {
    static let nameKey = "name"
    static let githubKey = "github"
    
    static var userName: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? "I Putu Wahyu Permadi"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nameKey)
        }
    }
    
    static var userGithub: String {
        get {
            return UserDefaults.standard.string(forKey: githubKey) ?? "https://github.com/wahyupermadie"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: githubKey)
        }
    }
    
    static func deteleAll() -> Bool {
        if let domain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: domain)
            synchronize()
            return true
        } else { return false }
    }
    
    static func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
