//
//  UserService.swift
//  Makestagram3
//
//  Created by Bella on 12/23/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child(Constants.Reference.users).child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(user)
        })
    }
    
        //?
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
        let userAttrs = [Constants.Dict.username: username]
        
        let ref = Database.database().reference().child(Constants.Reference.users).child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    // NEW
    static func following(for user: User = User.current, completion: @escaping ([User]) -> Void) {
        // 1
        let followingRef = Database.database().reference().child("following").child(user.uid)
        followingRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // 2
            guard let followingDict = snapshot.value as? [String : Bool] else {
                return completion([])
            }
            
            // 3
            var following = [User]()
            let dispatchGroup = DispatchGroup()
            
            for uid in followingDict.keys {
                dispatchGroup.enter()
                
                show(forUID: uid) { user in
                    if let user = user {
                        following.append(user)
                    }
                    
                    dispatchGroup.leave()
                }
            }
            
            // 4
            dispatchGroup.notify(queue: .main) {
                completion(following)
            }
        })
    }

    static func observeBets(for user: User = User.current, withCompletion completion: @escaping (DatabaseReference, [Bet]) -> Void) -> DatabaseHandle {
        let ref = Database.database().reference().child("bets").child(user.username)

        return ref.observe(.value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion(ref, [])
            }
            
            var bets = [Bet]()
            
            for betInfo in snapshot {
                guard  betInfo != nil else {
                    return completion(ref, [])
                }
                let betData = Bet(snapshot: betInfo)
                // TODO: safely unwrap line below. Refer to above method "show"
                bets.append(betData!)
                
            }
            completion(ref, bets)
        })
    }
    
//    static func observeBets(for user: User = User.current, withCompletion completion: @escaping (DatabaseReference, [Bet]) -> Void) -> DatabaseHandle {
//        let ref = Database.database().reference().child("bets").child(user.username)
//
//        return ref.observe(.value, with: { (snapshot) in
//            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
//                return completion(ref, [])
//            }
//            let dispatchGroup = DispatchGroup()
//            var bets = [Bet]()
//
//            for betSnap in snapshot {
//
//                dispatchGroup.enter()
//
//                guard let bet = Bet(snapshot: betSnap) else { return }
//                bets.append(bet)
//
//                dispatchGroup.leave()
//            }
//            completion(ref, bets)
//        })
//    }
    
//    static func posts(for user: User, completion: @escaping ([Bet]) -> Void) {
//        let ref = Database.database().reference().child("bets").child(user.uid)
//        
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
//                return completion([])
//            }
//            
//            completion(bets)
//        })
//    }
    
    static func usersExcludingCurrentUser(completion: @escaping ([User]) -> Void) {
        let currentUser = User.current
        
        let ref = Database.database().reference().child(Constants.Reference.users)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion([]) }
            
            let users = snapshot.compactMap(User.init).filter { $0.uid != currentUser.uid }
            
            let dispatchGroup = DispatchGroup()
            users.forEach { (user) in
                dispatchGroup.enter()
                
                FollowService.isUserFollowed(user) { (isFollowed) in
                    user.isFollowed = isFollowed
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                completion(users)
            })
        })
    }
}
