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
    
    static func addNumber(childVal: String) {
        
        let ref = Database.database().reference().child("users").child(User.current.uid)
        
        ref.updateChildValues(["phoneNumber" : childVal]) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }
    
    static func retrieveNumber(uid: String, completion: @escaping (String?) -> Void) {
        
        let ref = Database.database().reference().child("users").child(uid)
        
        ref.child("phoneNumber").observeSingleEvent(of: .value, with: { (snapshot) in
    
            if let number = snapshot.value as? String {
                return number
            }
        })
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

//    static func observeBets(for user: User = User.current, withCompletion completion: @escaping (DatabaseReference, [Bet]) -> Void) -> DatabaseHandle {
//        let ref = Database.database().reference().child("bets").child(user.username)
//
//        return ref.observe(.value, with: { (snapshot) in
//            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
//                return completion(ref, [])
//            }
//
//            let bets = snapshot.flatMap(Bet.init)
//            completion(ref, bets)
//        })
//    }
    
    // or this way
    
    static func observeBets(for user: User = User.current, withCompletion completion: @escaping ([String], DatabaseReference, [Bet]) -> Void) -> DatabaseHandle {
        
        let ref = Database.database().reference().child("bets").child(user.username)

        return ref.observe(.value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([], ref, [])
            }
// can you run it on phone is that fine bc its slow on mac -- yea i need the above ^
            var bets = [Bet]()
            var parentKeys = [String]()

            for betInfo in snapshot {
                // this guard won't work -- ok, let see why // what happen here is the decode, something doesnt match youer model
                guard  let betData = Bet(snapshot: betInfo) else {
                    return completion([], ref, [])
                }
                // to user is crashing -- why two???
                bets.append(betData) //1
                parentKeys.append(betInfo.ref.key ?? "nil")
                // TODO: safely unwrap line below. Refer to above method "show"

            }
            completion(parentKeys, ref, bets)
            // now i think everything works  =but sentTo and sender have 0 values, because it doesn't have data on the database
        })
    }

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
