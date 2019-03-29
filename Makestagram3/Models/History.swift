//
//  History.swift
//  Makestagram3
//
//  Created by Bella on 3/26/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class History {
    
    // MARK - Properties
    
    var key: String?
    let description: String
    let winner: String
    let loser: String
    let reward: String
    let episode: String
    let check: String
    
    init?(snapshot: DataSnapshot) {
        //do i need to include lastMessageSent is that why// not really
        guard !snapshot.key.isEmpty else {return nil}
        if let dict = snapshot.value as? [String : Any]{
        
            let description = dict["description"] as? String
            let winner = dict["winner"] as? String
            let loser = dict["loser"] as? String
            let reward = dict["reward"] as? String
            let episode = dict["episode"] as? String
            let check = dict["check"] as? String
            
            self.key = snapshot.key
            self.winner = winner ?? ""
            self.loser = loser ?? ""
            self.description = description ?? ""
            self.episode = episode ?? ""
            self.reward = reward ?? ""
            self.check = check ?? ""
        }else{
            return nil
        }
    }
}

