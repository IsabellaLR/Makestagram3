//
//  Constants.swift
//  Makestagram3
//
//  Created by Bella on 12/25/18.
//  Copyright © 2018 Bella. All rights reserved.
//

import Foundation

struct Constants {
    struct Segue {
        static let toCreateUsername = "toCreateUsername"
    }
    
    struct UserDefaults {
        static let currentUser = "currentUser"
    }
    
    struct Reference {
        static let posts = "posts"
        static let images = "images"
        static let users = "users"
        static let postLikes = "postLikes"
        static let followers = "followers"
        static let timeline = "timeline"
    }
    
    struct Dict {
        static let image_url = "image_url"
        static let image_height = "image_height"
        static let created_at = "created_at"
        static let username = "username"
        static let like_count = "like_count"
        static let poster = "poster"
        static let poster_uid = "poster_uid"
        static let uid = "uid"
        static let followers = "followers"
        static let following = "following"
    }
}
