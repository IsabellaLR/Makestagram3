//
//  PostService.swift
//  Makestagram3
//
//  Created by Bella on 12/25/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

struct BetService {
    
    static func create(description: String, senderUsername: String, sentUsernames: [String]) {
        
//        let lastMessageSent = lastMessageSent?.timeIntervalSince1970
        let betDict: [String : Any] = ["description" : description,
                                        "senderUsername" : senderUsername,
                                        "color": ""]
        let betRef = Database.database().reference().child("bets").child(User.current.username).childByAutoId()
        _ = betRef.key
        var multiUpdateValue = [String : Any]()
        for username in sentUsernames {
            multiUpdateValue["bets/\(username)/\(betRef.key ?? "")"] = betDict
        }
        let rootRef = Database.database().reference()
        rootRef.updateChildValues(multiUpdateValue) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }
    
    static func show(user: User, completion: @escaping (Bet?) -> Void) {
        // childAutoby create a new id/uid
        let betRef = Database.database().reference().child("bets").child(User.current.username)
        let ref = Database.database().reference().child("bets").child(user.username).child(betRef.key ?? "")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let bet = Bet(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(bet)
        })
    }
    
    static func setBetColor(color: String, senderUser: String) {

        let color = ["color": color]
        
        // change color for current user
        
        let betRef1 = Database.database().reference().child("bets").child(User.current.username)
        let ref1 = Database.database().reference().child("bets").child(User.current.username).child(betRef1.key ?? "")
        
        ref1.updateChildValues(color) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
        
        // change color for sender User
        let betRef2 = Database.database().reference().child("bets").child(senderUser)
        let ref2 = Database.database().reference().child("bets").child(senderUser).child(betRef2.key ?? "")

        ref2.updateChildValues(color) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }
}


