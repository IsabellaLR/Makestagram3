//
//  PostService.swift
//  Makestagram3
//
//  Created by Bella on 12/25/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostService {
//    static func create(for image: UIImage) {
//        let imageRef = StorageReference.newPostImageReference()
//        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
//            guard let downloadURL = downloadURL else {
//                return
//            }
//            
//            let urlString = downloadURL.absoluteString
//            let aspectHeight = image.aspectHeight
//            create(forURLString: urlString, aspectHeight: aspectHeight)
//        }
//    }
//    
//    private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
//        // 1
//        let currentUser = User.current
//        // 2
//        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
//        // 3
//        let dict = post.dictValue
//        
//        // 4
//        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
//        //5
//        postRef.updateChildValues(dict)
//    }
}

//private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
//    // 1
//    let currentUser = User.current
//    // 2
//    let bet = Bet(imageURL: urlString, imageHeight: aspectHeight)
//    // 3
//    let dict = bet.dictValue
//
//    // 4
//    let betRef = Database.database().reference().child("bets").child(currentUser.uid).childByAutoId()
//    //5
//    betRef.updateChildValues(dict)
//}
