//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 2/26/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import Foundation

struct Tweet {
    var id: Int = 0
    var text: String = ""
    var createdAt: String = ""
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var user: User?
    var retweeted: Bool = false
    var favorited: Bool = false

    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? Int ?? 0
        text = dictionary["text"] as? String ?? ""
        createdAt = dictionary["created_at"] as? String ?? ""
        retweetCount = dictionary["retweet_count"] as? Int ?? 0
        favoriteCount = dictionary["favorite_count"] as? Int ?? 0
        retweeted = dictionary["retweeted"] as? Bool ?? false
        favorited = dictionary["favorited"] as? Bool ?? false
        if let userDict = dictionary["user"] as? NSDictionary {
            user = User(dictionary: userDict)
        }
    }

    static func mockTimeline() -> [Tweet] {
        let users = [
            ["name": "Swift Community", "screen_name": "swift_community",
             "profile_image_url_https": "https://pbs.twimg.com/profile_images/placeholder1/photo.jpg"],
            ["name": "iOS Dev Weekly", "screen_name": "iosdevweekly",
             "profile_image_url_https": "https://pbs.twimg.com/profile_images/placeholder2/photo.jpg"],
            ["name": "Hacking with Swift", "screen_name": "twostraws",
             "profile_image_url_https": "https://pbs.twimg.com/profile_images/placeholder3/photo.jpg"],
        ]
        let texts = [
            "Swift 6 concurrency is a game changer for large codebases.",
            "Just shipped iOS 18 support — async/await made the diff.",
            "Reminder: WWDC session on Swift actors is worth watching twice.",
            "Hot take: @MainActor should have been the default from day one.",
            "Working on a new open-source Swift package. Stay tuned.",
        ]
        return zip(texts, users.cycled(count: texts.count)).enumerated().map { i, pair in
            let (text, user) = pair
            let d: [String: Any] = [
                "id": 1_000_000 + i,
                "text": text,
                "created_at": "\(i * 10)m ago",
                "retweet_count": (i + 1) * 47,
                "favorite_count": (i + 1) * 183,
                "retweeted": false,
                "favorited": false,
                "user": user
            ]
            return Tweet(dictionary: d as NSDictionary)
        }
    }
}

private extension Array {
    func cycled(count n: Int) -> [Element] {
        guard !isEmpty else { return [] }
        return (0..<n).map { self[$0 % self.count] }
    }
}
