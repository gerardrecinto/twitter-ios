//
//  AppDelegate.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 2/26/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotificationCenter.default.addObserver(
            forName: Notification.Name(User.userDidLogoutNotification),
            object: nil,
            queue: .main
        ) { [weak self] _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            self?.window?.rootViewController = storyboard.instantiateInitialViewController()
        }
        return true
    }
}

