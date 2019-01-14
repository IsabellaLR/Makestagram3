//
//  Profile.swift
//  Makestagram3
//
//  Created by Bella on 1/12/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class Profile {
    
    // MARK - Properties
    
    var key: String?
    let totalPoints: Int
    let posPoints: Int
    let negPoints: Int
    let wins: Int
    let losses: Int
    
    init?(snapshot: DataSnapshot) {
        guard !snapshot.key.isEmpty else {return nil}
        if let dict = snapshot.value as? [String : Any]{
            
            let totalPoints = dict["totalPoints"] as? Int
            let posPoints = dict["posPoints"] as? Int
            let negPoints = dict["negPoints"] as? Int
            let wins = dict["wins"] as? Int
            let losses = dict["losses"] as? Int
            
            self.key = snapshot.key
            self.totalPoints = totalPoints ?? 0
            self.posPoints = posPoints ?? 0
            self.negPoints = negPoints ?? 0
            self.wins = wins ?? 0
            self.losses = losses ?? 0
        }
        else{
            return nil
        }
    }
}
