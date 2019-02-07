//
//  onBoardingService.swift
//  Makestagram3
//
//  Created by Bella on 2/6/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct onBoardingService {
    
    //said couldn't access so removed 'private'
    static func pickCharacter(character: String) {
        //1
        let currentUID = User.current.uid
        let onBoardingData = ["throneChars/\(currentUID)/\(character)": true]
        
        //2
        let ref = Database.database().reference()
        ref.updateChildValues(onBoardingData) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
    //said couldn't access so removed 'private'
    static func removeCharacter(character: String) {
        
        let currentUID = User.current.uid
        
        let followData = ["throneChars/\(currentUID)/\(character)": NSNull()]
        
        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
    // What does the forCurrentUserWithSuccess do?
    
    static func setIsPicked(_ isFollowing: Bool, character: String, success: @escaping (Bool) -> Void) {
        if isFollowing {
            pickCharacter(character: character)
        } else {
            removeCharacter(character: character)
        }
    }
    
    static func isCharacterPicked(_ character: String, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
        let currentUID = User.current.uid
        let ref = Database.database().reference().child("throneChars").child(currentUID).child(character)
        
        ref.queryEqual(toValue: nil, childKey: currentUID).observeSingleEvent(of: .value, with: {(snapshot) in
            if let _ = snapshot.value as? [String : Bool] {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
}
