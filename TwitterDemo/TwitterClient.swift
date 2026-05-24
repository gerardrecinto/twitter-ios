//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 2/26/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//
//  Note: Twitter API v1.1 was deprecated March 2023.
//  Returns realistic mock data for portfolio demonstration.
//

import UIKit

@MainActor
final class TwitterClient {

    static let shared = TwitterClient()
    static var sharedInstance: TwitterClient? { shared }
    private init() {}

    var currentUser: User? = User(dictionary: [
        "name": "Gerard Recinto",
        "screen_name": "gerardrecinto",
        "profile_image_url_https": "",
        "followers_count": 1024,
        "friends_count": 512
    ])

    var isLoggedIn: Bool { currentUser != nil }

    func login(success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        success()
    }

    func logout() {
        NotificationCenter.default.post(name: Notification.Name(User.userDidLogoutNotification), object: nil)
    }

    func homeTimeline(success: @escaping ([Tweet]) -> Void, failure: @escaping (Error) -> Void) {
        success(Tweet.mockTimeline())
    }

    func like(id: Int, success: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void) {
        let tweet = Tweet.mockTimeline().first(where: { $0.id == id }) ?? Tweet.mockTimeline()[0]
        success(tweet)
    }

    func unlike(id: Int, success: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void) {
        let tweet = Tweet.mockTimeline().first(where: { $0.id == id }) ?? Tweet.mockTimeline()[0]
        success(tweet)
    }

    func retweet(id: Int, success: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void) {
        let tweet = Tweet.mockTimeline().first(where: { $0.id == id }) ?? Tweet.mockTimeline()[0]
        success(tweet)
    }

    func unretweet(id: Int, success: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void) {
        let tweet = Tweet.mockTimeline().first(where: { $0.id == id }) ?? Tweet.mockTimeline()[0]
        success(tweet)
    }
}
