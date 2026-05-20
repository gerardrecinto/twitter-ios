# Twitter Client

An iOS Twitter client built with Swift and UIKit, integrating the Twitter API v1.1 via OAuth 1.0a authentication.

## Features

- OAuth login with session persistence across app launches
- Home timeline displaying the 20 most recent tweets with pull-to-refresh and infinite scroll
- Compose new tweets with real-time character countdown
- Tweet detail view with retweet and favorite controls and animated interactions
- User profile pages showing tweet, following, and follower counts
- Segmented control for Tweets, Media, and Likes on profile
- Navigation bar and launch screen customization

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Swift |
| UI | UIKit, Auto Layout |
| Auth | Twitter API v1.1, OAuth 1.0a |
| Dependencies | CocoaPods |

## Setup

```bash
git clone https://github.com/gerardrecinto/twitterClient.git
cd twitterClient
pod install
open TwitterDemo.xcworkspace
```

Add your Twitter API consumer key and secret to the project before building.

## Demo

![Demo](http://imgur.com/EHZqzke.gif)
