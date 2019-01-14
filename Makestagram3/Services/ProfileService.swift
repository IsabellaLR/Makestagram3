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
    
    static func create(username: String, totalValue: Int, posValue: Int, negValue: Int, wins: Int, losses: Int) {
        
        //can take totalValue parameter out
        
        let rootRef = Database.database().reference()
        
        let profileRef = Database.database().reference().child("profile").child(username)
//        _ = profileRef.key
        
        var multiUpdateValue = [String : Any]()
        
        let profileDict: [String : Any] = ["totalPoints" :  posValue - negValue,
                                           "posPoints" :  posValue,
                                           "negPoints" : negValue,
                                           "wins" : wins,
                                           "losses" : losses]
        
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
//    static func create(username: String, posValue: Int, negValue: Int, wins: Int, losses: Int) {
//
//        let rootRef = Database.database().reference()
//
//        let profileRef = Database.database().reference().child("profile").child(username).childByAutoId()
//        _ = profileRef.key
//
//        profileRef.child(profileRef.key ?? "").observeSingleEvent(of: .value, with: { (snapshot) in
//
//                let userDict = snapshot.value as! [String: Any]
//
//                let posPoints = userDict["posPoints"] as! Int
//                let negPoints = userDict["negPoints"] as! Int
//                let winsNum = userDict["wins"] as! Int
//                let lossesNum = userDict["losses"] as! Int
//
//                let totalPoints = (posPoints + posValue) - (negPoints + negValue)
//                let posPointsValue = posPoints + posValue
//                let negPointsValue = negPoints + negValue
//                let winValue = winsNum + winsNum
//                let lossesValue = lossesNum + losses
//
//                UserDefaults.standard.set(totalPoints, forKey: "totalPoints")
//                UserDefaults.standard.set(totalPoints, forKey: "posPointsValue")
//                UserDefaults.standard.set(totalPoints, forKey: "negPointsValue")
//                UserDefaults.standard.set(totalPoints, forKey: "winValue")
//                UserDefaults.standard.set(totalPoints, forKey: "lossesValue")
//
//            })
//
////        let posPoints = profileRef.child(profileRef.key ?? "").value(forKey: "posPoints") as! Int
////        let negPoints = profileRef.child(profileRef.key ?? "").child("negPoints").value(forKey: "negPoints") as! Int
////        let winsNum = profileRef.child(profileRef.key ?? "").child("wins").value(forKey: "wins") as! Int
////        let lossesNum = profileRef.child(profileRef.key ?? "").child("losses").value(forKey: "losses") as! Int
//
////        posPoints.observe(.value, with: { (snapshot) in
////            guard let points = Profile(snapshot: snapshot) else {
////                return
////            }
////            return points
////        })
//
////        let totalPoints = (posPoints + posValue) - (negPoints + negValue)
////        let posPointsValue = posPoints + posValue
////        let negPointsValue = negPoints + negValue
////        let winValue = winsNum + winsNum
////        let lossValue = lossesNum + losses
////        let posPointsValue = (rootRef.child("profile").child(username).value(forKey: "posPoints") as! Int) + posValue
//
////        let negPointsValue = (rootRef.child("profile").child(username).value(forKey: "negPoints") as! Int) + negValue
//
//        var multiUpdateValue = [String : Any]()
//
//        let profileDict: [String : Any] = ["totalPoints" :  UserDefaults.standard.string(forKey: "totalPoints") ?? "nil",
//                                           "posPoints" :  UserDefaults.standard.string(forKey: "posPointsValue") ?? "nil",
//                                           "negPoints" : UserDefaults.standard.string(forKey: "negPointsValue") ?? "nil",
//                                           "wins" : UserDefaults.standard.string(forKey: "winValue") ?? "nil",
//                                           "losses" : UserDefaults.standard.string(forKey: "lossValue") ?? "nil"]
//
//        // update all 4 values
//
//        multiUpdateValue["profile/\(username)/\(profileRef.key ?? "")"] = profileDict
//
//        rootRef.updateChildValues(multiUpdateValue) { (error, ref) in
//            if let error = error {
//                assertionFailure(error.localizedDescription)
//                return
//            }
//        }
//    }

    static func show(for user: User = User.current, completion: @escaping (Profile?) -> Void) {

        let profileRef = Database.database().reference().child("profile").child(user.username)
        let ref = Database.database().reference().child("profile").child(user.username).child(profileRef.key ?? "")
        
        ref.observe(.value, with: { (snapshot) in
            guard let profile = Profile(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(profile)
        })
    }
    
//        ref.observe(.value, with: { (snapshot) in
//            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
//                return completion([])
//            }
//
//            var profiles = [Profile]()
//
//            for profileInfo in snapshot {
//                // this guard won't work -- ok, let see why // what happen here is the decode, something doesnt match youer model
//                guard  let profileData = Profile(snapshot: profileInfo) else {
//                    return completion([])
//                }
//                // to user is crashing -- why two???
//                profiles.append(profileData) //1
//                // TODO: safely unwrap line below. Refer to above method "show"
//
//            }
//            completion(profiles)
//        })
//    }
}
