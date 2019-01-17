//
//  ProfileService.swift
//  Makestagram3
//
//  Created by Bella on 1/12/19.
//  Copyright © 2019 Bella. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase

struct ProfileService {
    
    static func create(username: String, posValue: Int, negValue: Int, wins: Int, losses: Int) {
        
        //can take totalValue parameter out
        
        let rootRef = Database.database().reference()
        
        let profileRef = Database.database().reference().child("profile").child(username)
//        _ = profileRef.key
        
        var multiUpdateValue = [String : Any]()
        
        let profileDict: [String : Any] = ["totalPoints" :  posValue - negValue,
                                           "posPoints" :  posValue,
                                           "negPoints" : negValue,
                                           "wins" : wins,
                                           "losses" : losses,
                                           "image": ""]
        
        // update all 4 values
        
//        multiUpdateValue["profile/\(username)/\(profileRef.key ?? "")"] = profileDict
            multiUpdateValue["profile/\(username)"] = profileDict
        
        rootRef.updateChildValues(multiUpdateValue) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }

    static func show(for user: User = User.current, completion: @escaping (Profile?) -> Void) {

        let profileRef = Database.database().reference().child("profile").child(user.username)
        
        profileRef.observe(.value, with: { (snapshot) in
            guard let profile = Profile(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(profile)
        })
    }
    
    static func showOtherUser(user: String?, completion: @escaping (Profile?) -> Void) {
        
        let profileRef = Database.database().reference().child("profile").child(user ?? "")

        profileRef.observe(.value, with: { (snapshot) in
            let profile2 = Profile(snapshot: snapshot)
            return completion(profile2)
        })
    }
    
    static func createImage(for image: UIImage) {
        let imageRef = StorageReference.newPostImageReference()
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            create(forURLString: urlString)
        }
    }
    
    private static func create(forURLString urlString: String) {
        // 1
        let currentUser = User.current
        // 3
        let dict = ["image": urlString]
        
        // 4
        let profileRef = Database.database().reference().child("profile").child(currentUser.username)
        //5
        profileRef.updateChildValues(dict) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }
}
