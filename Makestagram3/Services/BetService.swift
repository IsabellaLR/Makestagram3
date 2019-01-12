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
    
    static func create(description: String, senderUsername: String, sentToUsernames: [String], points: String, episode: String) {

        var multiUpdateValue = [String : Any]()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM DD"
        let defaultTimeZoneStr = formatter.string(from: NSDate() as Date)
        
        for username in sentToUsernames {
            let rootRef = Database.database().reference()
            
            let betDict: [String : Any] = ["description" : description,
                                            "senderUsername" : senderUsername,
                                            "color": "white",
                                            "sentToUsernames": sentToUsernames,
                                            "sentToUser": username,
                                            "points": points,
                                            "episode": episode,
                                            "creationDate": defaultTimeZoneStr]
        
            let betRef = Database.database().reference().child("bets").child(username).childByAutoId()
            _ = betRef.key
    
            multiUpdateValue["bets/\(username)/\(betRef.key ?? "")"] = betDict

            rootRef.updateChildValues(multiUpdateValue) { (error, ref) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return
                }
            }
            
            //for current user
            
            multiUpdateValue["bets/\(User.current.username)/\(betRef.key ?? "")"] = betDict
            
            rootRef.updateChildValues(multiUpdateValue) { (error, ref) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return
                }
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
    

    static func setBetColor(color: String, parentKey: String, user1: String, user2: String) {

        let color = ["color": color]
        
        // change color for first user
        let betRef1 = Database.database().reference().child("bets").child(user1).child(parentKey)
                
        betRef1.updateChildValues(color) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    
        // change color for first user
        let betRef2 = Database.database().reference().child("bets").child(user2).child(parentKey)
    
        betRef2.updateChildValues(color) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }
}

    //for groupchat! color changes for all same parentKeys
//    static func setBetColor(color: String, parentKey: String, usernames: [String]) {
//
//        let color = ["color": color]
//
//        // change color for current user
//
//        for user in usernames{
//            let betRef = Database.database().reference().child("bets").child(user).child(parentKey)
//
//            betRef.updateChildValues(color) { (error, _) in
//                if let error = error {
//                    assertionFailure(error.localizedDescription)
//                    return
//                }
//            }
//        }
//    }

        
//        // change color for sender User
//        let betRef2 = Database.database().reference().child("bets").child(senderUser)
//        let ref2 = Database.database().reference().child("bets").child(senderUser).child(betRef2.key ?? "")
//
//        ref2.updateChildValues(color) { (error, _) in
//            if let error = error {
//                assertionFailure(error.localizedDescription)
//                return
//            }
//        }



