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
                                        "senderUsername" : senderUsername]
//                                        "sentToUsernames": User.current.username]
        // make sense, look at your betDict only 2 data and? is there more data you should pass? so ur saying i dont need the sendToUsernames dict in the Bet.swift?, well, you need to add it here as well, something like
        //ok i see but does it matter then if for the databas under each user will be their own username and user who sent bet?
        // if this post goes to every user than it doesnt really matter but if you wanna know who else bet on it, then yea youll need their uid k
        // That's all your problem or anything else? just realizing rn do i need this User.current.uid here, actually you dont need the childBy... so i can delete, hold on
        
        // the structure on your code and on the database doesn't look alike..
        //so which part should i delete
        // your database, so you can have data from this new ref, ac
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
    //
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


