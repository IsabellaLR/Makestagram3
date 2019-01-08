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
    
    static func create(description: String, senderUsername: String, sentToUsernames: [String]) {
        
//        let lastMessageSent = lastMessageSent?.timeIntervalSince1970
        let betDict: [String : Any] = ["description" : description,
                                        "senderUsername" : senderUsername]
        let betRef = Database.database().reference().child("bets").child(User.current.uid).childByAutoId()
        _ = betRef.key
        var multiUpdateValue = [String : Any]()
        for username in sentToUsernames {
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
        let betRef = Database.database().reference().child("bets").child(User.current.username).childByAutoId()
        let ref = Database.database().reference().child("bets").child(user.username).child(betRef.key ?? "")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let bet = Bet(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(bet)
        })
    }
//    static func observeMessages(forChatKey chatKey: String, completion: @escaping (DatabaseReference, Message?) -> Void) -> DatabaseHandle {
//        let messagesRef = Database.database().reference().child("messages").child(chatKey)
//
//        return messagesRef.observe(.childAdded, with: { snapshot in
//            guard let message = Message(snapshot: snapshot) else {
//                return completion(messagesRef, nil)
//            }
//
//            completion(messagesRef, message)
//        })
//    }

}


