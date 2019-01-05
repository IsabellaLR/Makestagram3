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
    
    static func create(from bet: Bet, completion: @escaping (Bet?) -> Void) {
        
        // 1
//        var membersDict = [String : Bool]()
//        for uid in bet.senderUIDs {
//            membersDict[uid] = true
//        }
        
        // 2
        let lastMessageSent = bet.lastMessageSent?.timeIntervalSince1970
        
        // 3
        let betDict: [String : Any] = ["description" : bet.description,
                                        "fromUser": bet.senderUsername,
                                        "lastMessageSent" : lastMessageSent!]
        
        // 4
        let betRef = Database.database().reference().child("bets").child(User.current.uid).childByAutoId()
        bet.key = betRef.key
        
        // 5
        var multiUpdateValue = [String : Any]()
        
        // 6
        for uid in bet.sentToUsernames {
            multiUpdateValue["bets/\(uid)/\(betRef.key)"] = betDict
        }
        
//        // 7
//        let messagesRef = FIRDatabase.database().reference().child("messages").child(chatRef.key).childByAutoId()
//        let messageKey = messagesRef.key
//
//        // 8
//        multiUpdateValue["messages/\(chatRef.key)/\(messageKey)"] = message.dictValue
        
        // 9
        let rootRef = Database.database().reference()
        rootRef.updateChildValues(multiUpdateValue) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
            
            completion(bet)
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


