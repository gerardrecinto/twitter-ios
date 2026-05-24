//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 2/26/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

@MainActor
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if TwitterClient.shared.isLoggedIn {
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }

    @IBAction func onLoginButton(_ sender: Any) {
        TwitterClient.shared.login(success: {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }, failure: { error in
            print("Login error: \(error.localizedDescription)")
        })
    }
}
