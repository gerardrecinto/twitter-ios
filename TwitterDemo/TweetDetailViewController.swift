//
//  TweetDetailViewController.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 2/28/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

@MainActor
class TweetDetailViewController: UIViewController {
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!

    var tweet: Tweet!
    var id: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        screennameLabel.text = tweet.user?.name ?? ""
        usernameLabel.text = "@" + (tweet.user?.screenName ?? "")
        textLabel.text = tweet.text
        dateLabel.text = tweet.createdAt
        id = tweet.id

        if let urlString = tweet.user?.profileImageUrl,
           let url = URL(string: urlString),
           let data = try? Data(contentsOf: url) {
            photoButton.setImage(UIImage(data: data), for: .normal)
        }
    }

    @IBAction func onLikeButton(_ sender: Any) {
        if tweet.favorited {
            TwitterClient.sharedInstance?.unlike(id: id, success: { [weak self] _ in
                self?.likeButton.setImage(UIImage(named: "favor-icon"), for: .normal)
            }, failure: { error in
                print(error.localizedDescription)
            })
            tweet.favoriteCount -= 1
        } else {
            TwitterClient.sharedInstance?.like(id: id, success: { [weak self] _ in
                self?.likeButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            }, failure: { error in
                print(error.localizedDescription)
            })
            tweet.favoriteCount += 1
        }
    }

    @IBAction func onRetweetButton(_ sender: Any) {
        if tweet.retweeted {
            TwitterClient.sharedInstance?.unretweet(id: id, success: { [weak self] _ in
                self?.retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            }, failure: { error in
                print(error.localizedDescription)
            })
            tweet.retweetCount -= 1
        } else {
            TwitterClient.sharedInstance?.retweet(id: id, success: { [weak self] _ in
                self?.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            }, failure: { error in
                print(error.localizedDescription)
            })
            tweet.retweetCount += 1
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        retweetCountLabel.text = String(tweet.retweetCount)
        likeCountLabel.text = String(tweet.favoriteCount)
        retweetButton.setImage(UIImage(named: tweet.retweeted ? "retweet-icon-green" : "retweet-icon"), for: .normal)
        likeButton.setImage(UIImage(named: tweet.favorited ? "favor-icon-red" : "favor-icon"), for: .normal)
        replyButton.setImage(UIImage(named: "reply-icon"), for: .normal)
        messageButton.setImage(UIImage(named: "message-icon"), for: .normal)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileSegue" {
            let vc = segue.destination as! ProfileViewController
            vc.user = tweet.user
        }
    }
}
