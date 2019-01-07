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
    let sentToUsernames: [String]
    let senderUsername: String
    var lastMessageSent: Date?
    
    init?(snapshot: DataSnapshot) {
        guard !snapshot.key.isEmpty,
            let dict = snapshot.value as? [String : Any],
            let senderUsername = dict["toUsername"] as? String,
            let description = dict["description"] as? String,
            let sentToUsernames = dict["fromUsername"] as? [String],
            let lastMessageSent = dict["lastMessageSent"] as? TimeInterval
            else { return nil }
        
        self.key = snapshot.key
        self.senderUsername = senderUsername
        self.sentToUsernames = sentToUsernames
        self.description = description
        self.lastMessageSent = Date(timeIntervalSince1970: lastMessageSent)
    }
}
