//
//  User.swift
//  Makestagram3
//
//  Created by Bella on 12/23/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class User: Codable {
    
    // MARK: -Properties
    
    let uid: String
    let username: String
    let phoneNumber: String
    var isFollowed = false
    
    // MARK: - Init
    
    init(uid: String, username: String, phoneNumber: String){
        self.uid = uid
        self.username = username
        self.phoneNumber = phoneNumber
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict[Constants.Dict.username] as? String,
            let phoneNumber = dict["phoneNumber"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
        self.phoneNumber = phoneNumber
    }
    
    // Mark: - Singleton
    
    private static var _current: User?
    
    static var current: User {
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        
        return currentUser
    }
    
    // MARK: - Class Methods
    
    class func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
            }
        }
        
        _current = user
    }
}

