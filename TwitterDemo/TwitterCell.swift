//
//  TwitterCell.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 2/27/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

class TwitterCell: UITableViewCell {
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!

    var rtCount: Int = 0
    var rtCountString: String = ""
    var didRt = false
    var likeCount: Int = 0
    var likeCountString: String = ""
    var didLike = false

    @IBAction func onRetweet(_ sender: Any) {
        rtCount += didRt ? -1 : 1
        didRt = !didRt
        setButtonCount()
    }

    @IBAction func onLike(_ sender: Any) {
        likeCount += didLike ? -1 : 1
        didLike = !didLike
        setButtonCount()
    }

    var tweet: Tweet! {
        didSet {
            screennameLabel.text = tweet.user?.name ?? ""
            usernameLabel.text = "@" + (tweet.user?.screenName ?? "")
            tweetLabel.text = tweet.text
            timestampLabel.text = tweet.createdAt

            replyButton.setImage(UIImage(named: "reply-icon"), for: .normal)

            if tweet.retweeted {
                retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
                didRt = true
            } else {
                retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
                didRt = false
            }

            if tweet.favorited {
                likeButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
                didLike = true
            } else {
                likeButton.setImage(UIImage(named: "favor-icon"), for: .normal)
                didLike = false
            }

            likeCount = tweet.favoriteCount
            rtCount = tweet.retweetCount
            setButtonCount()

            if let urlString = tweet.user?.profileImageUrl,
               let url = URL(string: urlString),
               let data = try? Data(contentsOf: url) {
                profileButton.setImage(UIImage(data: data), for: .normal)
            }
        }
    }

    func setButtonCount() {
        likeCountString = likeCount < 1000 ? "\(likeCount)" : "\(likeCount / 1000)K"
        likeButton.setTitle(likeCountString, for: .normal)
        rtCountString = rtCount < 1000 ? "\(rtCount)" : "\(rtCount / 1000)K"
        retweetButton.setTitle(rtCountString, for: .normal)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
