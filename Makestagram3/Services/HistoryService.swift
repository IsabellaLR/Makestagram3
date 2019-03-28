//
//  HistoryService.swift
//  Makestagram3
//
//  Created by Bella on 3/26/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

struct HistoryService {
    
    static func save(username: String, description: String, winner: String, loser: String, reward: String, episode: String) {
        
        let rootRef = Database.database().reference()

        var multiUpdateValue = [String : Any]()
        
        let betDict: [String : Any] = ["description" : description,
                                       "winner" : winner,
                                       "loser": loser,
                                       "reward": reward,
                                       "episode": episode]
            
        let betRef = Database.database().reference().child("history").child(username).childByAutoId()
        _ = betRef.key
        
        multiUpdateValue["history/\(username)/\(betRef.key ?? "")"] = betDict
        
        rootRef.updateChildValues(multiUpdateValue) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }
    
    static func observeHistory(for user: User = User.current, withCompletion completion: @escaping ([String], DatabaseReference, [History]) -> Void) -> DatabaseHandle {
        
        let ref = Database.database().reference().child("history").child(user.username)

        return ref.observe(.value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([], ref, [])
            }

            var bets = [History]()
            var parentKeys = [String]()

            for betInfo in snapshot {
                guard  let betData = History(snapshot: betInfo) else {
                    return completion([], ref, [])
                }
                bets.append(betData) //1
                parentKeys.append(betInfo.ref.key ?? "nil")
            }
            completion(parentKeys, ref, bets)
        })
    }
}
