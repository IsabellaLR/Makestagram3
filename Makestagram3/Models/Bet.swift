//
//  Bet.swift
//  Makestagram3
//
//  Created by Bella on 1/3/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class Bet {
    
    // MARK - Properties
    
    var key: String?
    let description: String
//    let sentToUsernames: [String]
    let senderUsername: String
    let color: String
    var lastMessageSent: Date?
    
    init?(snapshot: DataSnapshot) {
        //do i need to include lastMessageSent is that why// not really
        guard !snapshot.key.isEmpty else {return nil}
        if let dict = snapshot.value as? [String : Any]{
            
            let senderUsername = dict["senderUsername"] as? String // this line is crashing
            let description = dict["description"] as? String
            let color = dict["color"] as? String
//            let sentToUsernames = dict["sentToUsernames"] as? [String] // this line crashing as well // typo senderUsername
            // i thing you're right this line will crash -- run again
//            let lastMessageSent = dict["lastMessageSent"] as? TimeInterval
//            else {
//                print("oupss")
//                return nil }
        
        self.key = snapshot.key
        self.senderUsername = senderUsername ?? ""
//        self.sentToUsernames = sentToUsernames ?? [String]() //oops so i think should be lol right? -- let see
        self.description = description ?? "no description"
        self.color = color ?? "white"
//        self.lastMessageSent = Date(timeIntervalSince1970: lastMessageSent)
        }
        else{
            return nil
        }
    }
}
