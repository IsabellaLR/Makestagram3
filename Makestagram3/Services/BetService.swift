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
            multiUpdateValue["bets/\(username)/\(betRef.key)"] = betDict
        }
        let rootRef = Database.database().reference()
        rootRef.updateChildValues(multiUpdateValue) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }
    
//    static func checkForExistingChat(with user: User, completion: @escaping (Bet?) -> Void) {
//        // 1
//        let members = [user, User.current]
//        let hashValue = Chat.hash(forMembers: members)
//
//        // 2
//        let betRef = Database.database().reference().child("bets").child(User.current.uid)
//
//        // 3
//        let query = betRef.queryOrdered(byChild: "memberHash").queryEqual(toValue: hashValue)
//
//        // 4
//        query.observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let betSnap = snapshot.children.allObjects.first as? DataSnapshot,
//                let bet = Bet(snapshot: betSnap)
//                else { return completion(nil) }
//
//            completion(bet)
//        })
//    }
    
//    static func sendMessage(_ message: Message, for chat: Chat, success: ((Bool) -> Void)? = nil) {
//        guard let chatKey = chat.key else {
//            success?(false)
//            return
//        }
//        
//        var multiUpdateValue = [String : Any]()
//        
//        for uid in chat.memberUIDs {
//            let lastMessage = "\(message.sender.username): \(message.content)"
//            multiUpdateValue["chats/\(uid)/\(chatKey)/lastMessage"] = lastMessage
//            multiUpdateValue["chats/\(uid)/\(chatKey)/lastMessageSent"] = message.timestamp.timeIntervalSince1970
//        }
//        
//        let messagesRef = Database.database().reference().child("messages").child(chatKey).childByAutoId()
//        let messageKey = messagesRef.key
//        multiUpdateValue["messages/\(chatKey)/\(messageKey)"] = message.dictValue
//        
//        let rootRef = Database.database().reference()
//        rootRef.updateChildValues(multiUpdateValue, withCompletionBlock: { (error, ref) in
//            if let error = error {
//                assertionFailure(error.localizedDescription)
//                success?(false)
//                return
//            }
//            
//            success?(true)
//        })
//    }
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


