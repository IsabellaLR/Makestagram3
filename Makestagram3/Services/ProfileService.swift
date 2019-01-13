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
    
    static func create(username: String, posValue: Int, negValue: Int) {
        
        let rootRef = Database.database().reference()
        
        let posPointsValue = posValue
        let negPointsValue = negValue
//        let posPointsValue = (rootRef.child("profile").child(username).value(forKey: "posPoints") as! Int) + posValue
        
//        let negPointsValue = (rootRef.child("profile").child(username).value(forKey: "negPoints") as! Int) + negValue
    
        var multiUpdateValue = [String : Any]()
        
        let profileDict: [String : Any] = ["posPoints" : posPointsValue,
                                           "negPoints" : negPointsValue]
        
        let profileRef = Database.database().reference().child("profile").child(username).childByAutoId()
        _ = profileRef.key
        
        multiUpdateValue["profile/\(username)/\(profileRef.key ?? "")"] = profileDict
        
        rootRef.updateChildValues(multiUpdateValue) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }

    static func show(user: User, completion: @escaping ([Profile]) -> Void) {

        let profileRef = Database.database().reference().child("profile").child(user.username)
        let ref = Database.database().reference().child("profile").child(user.username).child(profileRef.key ?? "")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let profile = Profile(snapshot: snapshot) else {
                return completion([])
            }
            
            completion([profile])
        })
    }
}
