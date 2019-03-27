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
    }
    
    static func showHistory(username: String, completion: @escaping (Bet?) -> Void) {
        let betRef = Database.database().reference().child("history").child(User.current.username)
        let ref = Database.database().reference().child("history").child(username).child(betRef.key ?? "")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let history = History(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(history)
        })
}
