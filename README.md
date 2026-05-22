# Twitter iOS

![Swift](https://img.shields.io/badge/Swift-3%2B-F05138?logo=swift&logoColor=white)
![iOS 9+](https://img.shields.io/badge/iOS-9%2B-000000?logo=apple&logoColor=white)
![UIKit](https://img.shields.io/badge/UIKit-Auto%20Layout-blue)
![OAuth](https://img.shields.io/badge/Auth-OAuth%201.0a-gray)

![Demo](docs/assets/demo2.gif)

iOS Twitter client built with Swift and UIKit, integrating the Twitter API v1.1 via OAuth 1.0a authentication.

## Features

- OAuth login with session persistence across app launches
- Home timeline with the 20 most recent tweets, pull-to-refresh, and infinite scroll
- Compose new tweets with real-time character countdown
- Tweet detail view with retweet and favorite controls
- User profile pages showing tweet, following, and follower counts
- Segmented control for Tweets, Media, and Likes on profile

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Swift |
| UI | UIKit, Auto Layout |
| Auth | Twitter API v1.1, OAuth 1.0a |
| Dependencies | CocoaPods |

## Setup

```bash
git clone https://github.com/gerardrecinto/twitter-ios.git
cd twitter-ios
pod install
open TwitterDemo.xcworkspace
```

Add your Twitter API consumer key and secret before building.
