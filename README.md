# Twitter iOS

![Swift](https://img.shields.io/badge/Swift-3%2B-F05138?logo=swift&logoColor=white)
![iOS 9+](https://img.shields.io/badge/iOS-9%2B-000000?logo=apple&logoColor=white)
![UIKit](https://img.shields.io/badge/UIKit-Auto%20Layout-blue)
![AFNetworking](https://img.shields.io/badge/Networking-AFNetworking%203.0-lightgrey)
![OAuth](https://img.shields.io/badge/Auth-OAuth%201.0a-1DA1F2)

![Demo](docs/assets/demo2.gif)

> Full iOS Twitter client that drives the Twitter API v1.1 through a `BDBOAuth1SessionManager` subclass, handling the complete three-legged OAuth 1.0a flow with session persistence, an infinite-scroll timeline, live retweet/like toggling, and user profile pages.

## Features

- **OAuth 1.0a three-legged flow:** `TwitterClient.login` fetches a request token via `fetchRequestToken(withPath:method:callbackURL:...)`, opens `api.twitter.com/oauth/authorize` in Safari, then `handleOpenUrl` exchanges the callback `oauth_token` for an access token via `fetchAccessToken(withPath:method:requestToken:...)`
- **Session persistence:** The authenticated user is serialized to `NSData` with `JSONSerialization.data` and stored in `UserDefaults` under `"currentUserData"`, restoring `User.currentUser` on next launch without re-authenticating
- **Home timeline:** `TwitterClient.homeTimeline` issues a GET to `1.1/statuses/home_timeline.json` through `BDBOAuth1SessionManager`, deserializes the response array into `[Tweet]` via `Tweet.tweetsWithArray`, and delivers results on the main queue
- **Infinite scroll:** `TweetsViewController` implements `UIScrollViewDelegate.scrollViewDidScroll` — when `contentOffset.y` exceeds `contentSize.height - bounds.height` while dragging, it sets `isMoreDataLoading = true`, animates a custom `InfiniteScrollActivityView` spinner added to the table's content inset, and fetches the next batch
- **Pull-to-refresh:** A `UIRefreshControl` inserted at subview index 0; its `valueChanged` action calls `TwitterClient.homeTimeline` and ends refreshing in the success handler
- **Retweet and like toggling:** `TweetDetailViewController` calls `TwitterClient.retweet`/`unretweet` (POST to `1.1/statuses/retweet/{id}.json` / `unretweet/{id}.json`) and `like`/`unlike` (POST to `1.1/favorites/create.json` / `destroy.json`), updating button images between normal and green/red variants on success
- **Relative timestamps:** `TwitterCell` computes `timeDiff = Date().timeIntervalSince(tweet.timestamp)` and formats it as `"Xm"`, `"Xh"`, or `"X days ago"` without any third-party date library
- **User profile view:** `ProfileViewController` loads cover photo and profile image via `UIImageView.setImageWith(_:)` and displays tweet count, follower count, and following count parsed from `account/verify_credentials.json`
- **Compose screen:** `ComposeViewController` enforces the 140-character limit in `UITextViewDelegate.textView(_:shouldChangeTextIn:replacementText:)`, updating a countdown `UILabel` on every keystroke

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Swift 3 |
| UI | UIKit, Auto Layout, UITableViewAutomaticDimension |
| Networking | AFNetworking 3.0, BDBOAuth1Manager 2.0 |
| API | Twitter API v1.1 |
| Auth | OAuth 1.0a (BDBOAuth1SessionManager) |
| Persistence | UserDefaults (user session), NotificationCenter (logout broadcast) |
| Dependencies | CocoaPods |

## Architecture

`TwitterClient` is a singleton `BDBOAuth1SessionManager` subclass that owns all API calls. `LoginViewController` triggers the OAuth flow; on success it segues to `TweetsViewController` which drives the main `UITableView`. Tapping a cell passes the `Tweet` model through `prepare(for:sender:)` to `TweetDetailViewController`. Tapping a profile avatar button walks the view hierarchy (`button.superview?.superview`) to resolve the cell's index path and passes the `User` model to `ProfileViewController`. Logout posts a `UserDidLogout` notification that `AppDelegate` observes to swap the root view controller back to `LoginViewController`.

## Key Implementation

**BDBOAuth1SessionManager over AFHTTPSessionManager:** `TwitterClient` subclasses `BDBOAuth1SessionManager` rather than plain `AFHTTPSessionManager` so OAuth 1.0a signature generation (nonce, timestamp, HMAC-SHA1) is handled by BDBOAuth1Manager on every request, not manually constructed per-call.

**Infinite scroll with `InfiniteScrollActivityView`:** A custom `UIView` wrapping `UIActivityIndicatorView` is added below the table's last row by expanding `tableView.contentInset.bottom` by `InfiniteScrollActivityView.defaultHeight`. Its frame is repositioned to `tableView.contentSize.height` on each scroll event so it stays anchored past the last cell.

**Like/retweet state from API:** `Tweet.init` reads `favorited` and `retweeted` booleans directly from the JSON dictionary, so cell icons reflect server-side state on initial load rather than being derived from local toggle logic alone.

## Setup

```bash
git clone https://github.com/gerardrecinto/twitter-ios.git
cd twitter-ios
pod install
open TwitterDemo.xcworkspace
```

Add your Twitter API consumer key and consumer secret to `TwitterClient.swift` before building.
