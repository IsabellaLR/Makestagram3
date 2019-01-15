//
//  ProfileService.swift
//  Makestagram3
//
//  Created by Bella on 1/12/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase

struct ProfileService {
    
    static func create(username: String, posValue: Int, negValue: Int, wins: Int, losses: Int) {
        
        //can take totalValue parameter out
        
        let rootRef = Database.database().reference()
        
        let profileRef = Database.database().reference().child("profile").child(username)
//        _ = profileRef.key
        
        var multiUpdateValue = [String : Any]()
        
        let profileDict: [String : Any] = ["totalPoints" :  posValue - negValue,
                                           "posPoints" :  posValue,
                                           "negPoints" : negValue,
                                           "wins" : wins,
                                           "losses" : losses]
        
        // update all 4 values
        
//        multiUpdateValue["profile/\(username)/\(profileRef.key ?? "")"] = profileDict
            multiUpdateValue["profile/\(username)"] = profileDict
        
        rootRef.updateChildValues(multiUpdateValue) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }

    static func show(for user: User = User.current, completion: @escaping (Profile?) -> Void) {

        let profileRef = Database.database().reference().child("profile").child(user.username)
        
        profileRef.observe(.value, with: { (snapshot) in
            guard let profile = Profile(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(profile)
        })
    }
    
    static func showOtherUser(for user: String, completion: @escaping (Profile?) -> Void) {
        
        let profileRef = Database.database().reference().child("profile").child(user)
        
        profileRef.observe(.value, with: { (snapshot) in
            guard let profile2 = Profile(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(profile2)
        })
    }
}
