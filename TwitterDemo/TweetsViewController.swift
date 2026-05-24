//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Gerard Recinto on 2/27/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

@MainActor
class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var tweets: [Tweet] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        applyTheme()
        loadTimeline()
    }

    @objc private func refresh(_ refreshControl: UIRefreshControl) {
        loadTimeline()
        refreshControl.endRefreshing()
    }

    private func loadTimeline() {
        TwitterClient.shared.homeTimeline(success: { [weak self] tweets in
            self?.tweets = tweets
            self?.tableView.reloadData()
        }, failure: { error in
            print(error.localizedDescription)
        })
    }

    private func applyTheme() {
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.11, green: 0.63, blue: 0.95, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        if let logo = UIImage(named: "SmallLogo") {
            navigationItem.titleView = UIImageView(image: logo)
        } else {
            title = "Twitter"
        }
    }

    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.shared.logout()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterCell", for: indexPath) as! TwitterCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else { return }
        let tweet = tweets[indexPath.row]
        if segue.identifier == "detailSegue" {
            (segue.destination as? TweetDetailViewController)?.tweet = tweet
        } else if segue.identifier == "profileSegue" {
            (segue.destination as? ProfileViewController)?.user = tweet.user
        }
    }
}

// MARK: - InfiniteScrollActivityView (kept for storyboard compatibility)

class InfiniteScrollActivityView: UIView {
    static let defaultHeight: CGFloat = 60.0
    private let activityIndicatorView = UIActivityIndicatorView(style: .medium)

    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); setup() }
    override init(frame: CGRect) { super.init(frame: frame); setup() }

    private func setup() {
        activityIndicatorView.hidesWhenStopped = true
        addSubview(activityIndicatorView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }

    func startAnimating() { isHidden = false; activityIndicatorView.startAnimating() }
    func stopAnimating() { activityIndicatorView.stopAnimating(); isHidden = true }
}
