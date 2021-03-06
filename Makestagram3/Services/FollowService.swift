//
//  FollowService.swift
//  Makestagram3
//
//  Created by Bella on 12/29/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct FollowService {
    private static func followUser(_ user: User, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        //1
        let currentUID = User.current.uid
        let followData = ["followers/\(user.uid)/\(currentUID)": true,
                          "following/\(currentUID)/\(user.uid)": true]
        
        //2
        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            
            //3
            success(error == nil)
        }
    }
    
    private static func unfollowUser(_ user: User, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        let currentUID = User.current.uid
        // Use NSNull() object instead of nil because updateChildValues expects type [Hashable : Any]
        // http://stackoverflow.com/questions/38462074/using-updatechildvalues-to-delete-from-firebase
        let followData = ["followers/\(user.uid)/\(currentUID)" : NSNull(),
                          "following/\(currentUID)/\(user.uid)" : NSNull()]
        
        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            
            success(error == nil)
        }
    }
    
    static func setIsFollowing(_ isFollowing: Bool, fromCurrentUserTo followee: User, success: @escaping (Bool) -> Void) {
        if isFollowing {
            followUser(followee, forCurrentUserWithSuccess: success)
        } else {
            unfollowUser(followee, forCurrentUserWithSuccess: success)
        }
    }
    
    static func isUserFollowed(_ user: User, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
        let currentUID = User.current.uid
        let ref = Database.database().reference().child("followers").child(user.uid)
        
        ref.queryEqual(toValue: nil, childKey: currentUID).observeSingleEvent(of: .value, with: {(snapshot) in
            if let _ = snapshot.value as? [String : Bool] {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    static func followingUsernames(for user: User, completion: @escaping ([String]) -> Void) {
        
        let followingRef = Database.database().reference().child("following").child(user.uid)
        
        followingRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let followingDict = snapshot.value as? [String : Bool] else {
                return completion([])
            }
            
            let Keys = Array(followingDict.keys)
            
            //convert user.uid into username to display on sendBets table
            var followingKeys = [String]()
            
            for following in Keys {
                let ref2 = Database.database().reference().child("users").child(following).child("username")
                ref2.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if let item = snapshot.value as? String{
                        followingKeys.append(item)
                    }
                    completion(followingKeys)
                })
            }
        })
    }
    
    static func followerUsernames(for user: User, completion: @escaping ([String]) -> Void) {
        
        let followingRef = Database.database().reference().child("followers").child(user.uid)
        
        followingRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let followingDict = snapshot.value as? [String : Bool] else {
                return completion([])
            }
            
            let Keys = Array(followingDict.keys)
            
            //convert user.uid into username to display on sendBets table
            var followingKeys = [String]()
            
            for following in Keys {
                let ref2 = Database.database().reference().child("users").child(following).child("username")
                ref2.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if let item = snapshot.value as? String{
                        followingKeys.append(item)
                    }
                    completion(followingKeys)
                })
            }
        })
    }
    
    static func followingUids(for user: User, completion: @escaping ([String]) -> Void) {
        
        let followingRef = Database.database().reference().child("following").child(user.uid)
        
        followingRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let followingDict = snapshot.value as? [String : Bool] else {
                return completion([])
            }
            
            let Keys = Array(followingDict.keys)
            
            //convert user.uid into username to display on sendBets table
            var followingKeys2 = [String]()
            
            for following in Keys {
                let ref2 = Database.database().reference().child("users").child(following).child("uid")
                ref2.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if let item = snapshot.value as? String{
                        followingKeys2.append(item)
                    }
                    completion(followingKeys2)
                })
            }
        })
    }
    
    static func followerUids(for user: User, completion: @escaping ([String]) -> Void) {
        
        let followingRef = Database.database().reference().child("followers").child(user.uid)
        
        followingRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let followingDict = snapshot.value as? [String : Bool] else {
                return completion([])
            }
            
            let Keys = Array(followingDict.keys)
            
            //convert user.uid into username to display on sendBets table
            var followingKeys2 = [String]()
            
            for following in Keys {
                let ref2 = Database.database().reference().child("users").child(following).child("uid")
                ref2.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if let item = snapshot.value as? String{
                        followingKeys2.append(item)
                    }
                    completion(followingKeys2)
                })
            }
        })
    }
}


