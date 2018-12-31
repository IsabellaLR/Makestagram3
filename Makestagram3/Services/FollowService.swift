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

    static func retrieveFollowers(for user: User, completion: @escaping ([User]?) -> Void) {
        Database.database().reference().child("followers").child(user.uid).observe(.childAdded, with: { (snapshot) in
            
            if snapshot.childrenCount == 0{
                return completion(nil)
            }
            
            var followersArr = [User]()
            for snap in snapshot.children {
                let user = User(snapshot: snap as! DataSnapshot)
                followersArr.append(user!)
            }
            return completion(followersArr)
        })
    }
}
