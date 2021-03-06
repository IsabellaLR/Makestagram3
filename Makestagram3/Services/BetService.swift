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
                                            "creationDate": defaultTimeZoneStr,
                                            "winner": "tbd"]
        
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
            
            multiUpdateValue["bets/\(User.current.uid)/\(betRef.key ?? "")"] = betDict
            
            rootRef.updateChildValues(multiUpdateValue) { (error, ref) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return
                }
            }
        }
    }

    static func addPremieur(child: String, childVal: [String]) {
        
        let betRef = Database.database().reference().child("bets").child(User.current.uid)
    
        betRef.updateChildValues([child : childVal]) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }
    
    static func show(user: User, completion: @escaping (Bet?) -> Void) {
        // childAutoby create a new id/uid
        let betRef = Database.database().reference().child("bets").child(User.current.uid)
        let ref = Database.database().reference().child("bets").child(user.uid).child(betRef.key ?? "")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let bet = Bet(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(bet)
        })
    }
    
    static func remove(parentKey: String, user: String){
        Database.database().reference().child("bets").child(User.current.uid).child(parentKey).removeValue()
        Database.database().reference().child("bets").child(user).child(parentKey).removeValue()
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
    
    static func setBetWinner(parentKey: String, user1: String, user2: String) {
        
        let current = User.current.username
        
        let winner = ["winner": current]
        
        let betRef1 = Database.database().reference().child("bets").child(user1).child(parentKey)
        
        betRef1.updateChildValues(winner) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }

        let betRef2 = Database.database().reference().child("bets").child(user2).child(parentKey)
        
        betRef2.updateChildValues(winner) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }
}
