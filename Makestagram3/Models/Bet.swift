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
    
//    init(members: [User]){
//        // 1
////        assert(members.count == 2, "There must be two members in a chat.")
//
//        // 2
////        self.title = members.reduce("") { (acc, cur) -> String in
////            return acc.isEmpty ? cur.username : "\(acc), \(cur.username)"
////        }
//        // 3
//        self.memberHash = Bet.hash(forMembers: members)
//        // 4
//        self.senderUIDs = members.map { $0.uid }
//    }
    
    // MARK: - Class Methods
    
//    static func hash(forMembers members: [User]) -> String {
////        guard members.count == 2 else {
////            fatalError("There must be two members to compute member hash.")
////        }
//
//        let firstMember = members[0]
//        let secondMember = members[1]
//
//        let memberHash = String(firstMember.uid.hashValue ^ secondMember.uid.hashValue)
//        return memberHash
//    }
}
