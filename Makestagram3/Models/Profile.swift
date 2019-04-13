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
    let couple: String
    let ship: String
    let fav: String
    let throneChar: String
    let imageURL: String
    let house: String
    
    init?(snapshot: DataSnapshot) {
        guard !snapshot.key.isEmpty else {return nil}
        if let dict = snapshot.value as? [String : Any]{
            
            let throneChar = dict["throneChar"] as? String
            let couple = dict["couple"] as? String
            let ship = dict["ship"] as? String
            let fav = dict["fav"] as? String
            let totalPoints = dict["totalPoints"] as? Int
            let posPoints = dict["posPoints"] as? Int
            let negPoints = dict["negPoints"] as? Int
            let wins = dict["wins"] as? Int
            let losses = dict["losses"] as? Int
            let imageURL = dict["image"] as? String
            let house = dict["house"] as? String
            
            self.key = snapshot.key
            self.throneChar = throneChar ?? ""
            self.couple = couple ?? ""
            self.ship = ship ?? ""
            self.fav = fav ?? ""
            self.totalPoints = totalPoints ?? 0
            self.posPoints = posPoints ?? 0
            self.negPoints = negPoints ?? 0
            self.wins = wins ?? 0
            self.losses = losses ?? 0
            self.imageURL = imageURL ?? ""
            self.house = house ?? ""
        }
        else{
            return nil
        }
    }
}
