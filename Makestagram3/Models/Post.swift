////
////  Post.swift
////  Makestagram3
////
////  Created by Bella on 12/26/18.
////  Copyright © 2018 Bella. All rights reserved.
////
//
//import UIKit
//import FirebaseDatabase.FIRDataSnapshot
//
//class Bet {
//    var key: String?
//    var imageURL: String
//    let imageHeight: CGFloat
//    let creationDate: Date
//
//    init(imageURL: String, imageHeight: CGFloat) {
//        self.imageURL = imageURL
//        self.imageHeight = imageHeight
//        self.creationDate = Date()
//    }
//
//    var dictValue: [String: Any] {
//        let createdAgo = creationDate.timeIntervalSince1970
//
//        return ["image_url": imageURL,
//               "image_height": imageHeight,
//               "created_at": createdAgo]
//    }
//
//    init?(snapshot: DataSnapshot) {
//        guard let dict = snapshot.value as? [String : Any],
//            let imageURL = dict["image_url"] as? String,
//            let imageHeight = dict["image_height"] as? CGFloat,
//            let createdAgo = dict["created_at"] as? TimeInterval
//            else { return nil }
//
//        self.key = snapshot.key
//        self.imageURL = imageURL
//        self.imageHeight = imageHeight
//        self.creationDate = Date(timeIntervalSince1970: createdAgo)
//    }
//}
