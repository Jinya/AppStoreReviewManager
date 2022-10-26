# AppStoreReviewManager

An easy way to access reviews for your app instead of writing repetitive and redundant codes for every app.


## Requirements

iOS 11.0+, Swift 5.7+


## Installation

#### Swift Package Manager (Recommended)

- Xcode >  File > Swift Packages > Add Package Dependency
- Add `https://github.com/Jinya/AppStoreReviewManager.git`
- Select "Up to Next Minor" (recommend using the latest version)


## How to Use

```swift
import AppStoreReviewManager

// Get the App Store product page URL with a given App Store ID.
let productURL = AppStoreReviewManager.productURL(with: YOUR_PRODUCT_APP_STORE_ID)!

// Tells StoreKit to ask the user to rate or review your app, if appropriate.
// This is a convenient wrapper method for `SKStoreReviewController.requestReview()` and `SKStoreReviewController.requestReview(in:)`.
AppStoreReviewManager.requestReview()

// Open the App Store product page and present a write review form in the App Store.
AppStoreReviewManager.openProductPageForReview(with: YOUR_PRODUCT_APP_STORE_ID)
```


## MIT License 

AppStoreReviewManager released under the MIT license. See LICENSE for details.
