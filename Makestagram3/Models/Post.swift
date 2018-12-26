//
//  Post.swift
//  Makestagram3
//
//  Created by Bella on 12/26/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Post {
    var key: String?
    var imageURL: String
    let imageHeight: CGFloat
    let creationDate: Date
    
    init(imageURL: String, imageHeight: CGFloat) {
        self.imageURL = imageURL
        self.imageHeight = imageHeight
        self.creationDate = Date()
    }
    
    var dictValue: [String: Any] {
        let createdAgo = creationDate.timeIntervalSince1970
        
        return ["image_url": imageURL,
               "image_height": imageHeight,
               "created_at": createdAgo]
    }
}
