# AppStoreReviewManager

An easy way to access reviews for your app instead of writing repetitive and redundant codes for every app.


## Requirements

iOS 9.0+, Swift 5.5


## Installation

#### Swift Package Manager (Recommended)

- File > Swift Packages > Add Package Dependency
- Add `https://github.com/Jinya/AppStoreReviewManager.git`
- Select "Exact Version" (recommend using the latest exact version)


## How to Use

```swift
import AppStoreReviewManager

// Get App Store page url String for your app
let urlString = AppStoreReviewManager.appStorePageURLString(with: YOUR_APP_APP_STORE_ID)

// Open App Store page for your app
AppStoreReviewManager.openAppStorePage(with: YOUR_APP_APP_STORE_ID)

// Request review without leaving your app
AppStoreReviewManager.requestReviewInApp()

// Open App Store review page for your app to review
AppStoreReviewManager.requestReviewInAppStore(with: YOUR_APP_APP_STORE_ID)
```


## MIT License 

AppStoreReviewManager released under the MIT license. See LICENSE for details.
