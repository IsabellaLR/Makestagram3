//
//  ClaimBet.swift
//  Makestagram3
//
//  Created by Bella on 3/24/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class ClaimBet {
    
    // MARK - Properties
    
    var key: String?
    let description: String
    let sentToUsernames: [String]
    let senderUsername: String
    let sentToUser: String
    let color: String
    let points: String
    let episode: String
    let creationDate: String
    let winner: String
    
    init?(snapshot: DataSnapshot) {
        //do i need to include lastMessageSent is that why// not really
        guard !snapshot.key.isEmpty else {return nil}
        if let dict = snapshot.value as? [String : Any]{
            
            let senderUsername = dict["senderUsername"] as? String // this line is crashing
            let description = dict["description"] as? String
            let color = dict["color"] as? String
            let sentToUsernames = dict["sentToUsernames"] as? [String]
            let sentToUser = dict["sentToUser"] as? String
            let points = dict["points"] as? String
            let episode = dict["episode"] as? String
            // i thing you're right this line will crash -- run again
            let creationDate = dict["creationDate"] as? String
            let winner = dict["winner"] as? String
            
            self.key = snapshot.key
            self.senderUsername = senderUsername ?? ""
            self.sentToUsernames = sentToUsernames ?? [""]
            self.description = description ?? "no description"
            self.sentToUser = sentToUser ?? ""
            self.color = color ?? "white"
            self.points = points ?? "0"
            self.episode = episode ?? ""
            self.creationDate = creationDate ?? "idk man"
            self.winner = winner ?? ""
        }
        else{
            return nil
        }
    }
    
    //    var dictValue: [String : Any] {
    //        let createdAgo = creationDate.timeIntervalSince1970
    //
    //        return [Constants.Dict.created_at : createdAgo]
    //    }
}

