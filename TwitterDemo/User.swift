//
//  User.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 2/26/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import Foundation

class User {
    static let userDidLogoutNotification = "UserDidLogout"

    var name: String = ""
    var screenName: String = ""
    var profileImageUrl: String = ""
    var followersCount: Int = 0
    var friendsCount: Int = 0

    static var currentUser: User? = nil

    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String ?? ""
        screenName = dictionary["screen_name"] as? String ?? ""
        profileImageUrl = dictionary["profile_image_url_https"] as? String ?? ""
        followersCount = dictionary["followers_count"] as? Int ?? 0
        friendsCount = dictionary["friends_count"] as? Int ?? 0
    }
}
