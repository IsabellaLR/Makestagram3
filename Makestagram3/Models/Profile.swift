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
    //    let username: String
    let posPoints: Int
    let negPoints: Int
    
    init?(snapshot: DataSnapshot) {
        guard !snapshot.key.isEmpty else {return nil}
        if let dict = snapshot.value as? [String : Any]{
            
            //            let username = dict["username"] as? String
            let posPoints = dict["posPoints"] as? Int
            let negPoints = dict["negPoints"] as? Int
            
            self.key = snapshot.key
            //            self.username = username ?? ""
            self.posPoints = posPoints ?? 0
            self.negPoints = negPoints ?? 0
        }
        else{
            return nil
        }
    }
}
