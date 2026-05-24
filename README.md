# X iOS

![Swift](https://img.shields.io/badge/Swift-6.0-F05138?logo=swift&logoColor=white)
![iOS 16+](https://img.shields.io/badge/iOS-16%2B-000000?logo=apple&logoColor=white)
![UIKit](https://img.shields.io/badge/UIKit-Auto%20Layout-blue)
![API](https://img.shields.io/badge/API-X%20%28Twitter%29%20v1.1-000000)

![Demo](docs/assets/demo2.gif)

> Full iOS X (formerly Twitter) client. Implements the complete OAuth 1.0a flow, infinite-scroll timeline, live retweet/like toggling, and user profile pages. API v1.1 is deprecated as of March 2023 — app uses mock data for portfolio demonstration.

## Features

- **OAuth 1.0a three-legged flow:** `TwitterClient.login` fetches a request token, opens the X authorization URL in Safari, then exchanges the callback `oauth_token` for an access token
- **Session persistence:** Authenticated user serialized to `UserDefaults`, restoring on next launch without re-authenticating
- **Home timeline:** `TwitterClient.homeTimeline` returns mock tweets via `Tweet.mockTimeline()`, delivered on the main actor
- **Infinite scroll:** `TweetsViewController` implements `UIScrollViewDelegate.scrollViewDidScroll` — animates a custom `InfiniteScrollActivityView` spinner and fetches the next batch when near the bottom
- **Pull-to-refresh:** `UIRefreshControl` inserted at subview index 0; `valueChanged` action reloads the timeline
- **Retweet and like toggling:** `TweetDetailViewController` calls `TwitterClient.retweet`/`unretweet` and `like`/`unlike`, updating button images on success
- **Relative timestamps:** `TwitterCell` displays pre-formatted `createdAt` strings without any third-party date library
- **User profile view:** `ProfileViewController` displays follower/following counts and profile image
- **Compose screen:** `ComposeViewController` enforces the 140-character limit via `UITextViewDelegate`, updating a countdown label on every keystroke

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Swift 6.0 |
| UI | UIKit, Auto Layout, UITableView.automaticDimension |
| Networking | URLSession (native) |
| API | X (Twitter) API v1.1 — mock data (deprecated March 2023) |
| Auth | OAuth 1.0a flow (mock) |
| Persistence | UserDefaults (session), NotificationCenter (logout broadcast) |
| Dependencies | CocoaPods |

## Architecture

`TwitterClient` is a `@MainActor` singleton that owns all API calls. `LoginViewController` triggers the OAuth flow; on success it segues to `TweetsViewController` which drives the main `UITableView`. Tapping a cell passes the `Tweet` model through `prepare(for:sender:)` to `TweetDetailViewController`. Tapping a profile avatar passes the `User` model to `ProfileViewController`. Logout posts a `UserDidLogout` notification that `AppDelegate` observes to swap the root view controller back to `LoginViewController`.
