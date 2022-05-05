//
// AppStoreReviewManager
// The MIT License (MIT)
//
// Copyright (c) 2021-2022 Jinya (https://github.com/Jinya)

import UIKit
import StoreKit

@available(iOS 9.0, *)
public struct AppStoreReviewManager {
    /// Base URL string
    private static let base = "https://apps.apple.com/app"

    /// Get the App Store product page URL string with a given App Store ID.
    private static func productURLString(with appStoreID: String) -> String {
        return base + "/id\(appStoreID)"
    }

    /// Get the App Store product page URL with a given App Store ID.
    /// - Parameter appStoreID: The App Store ID of a product.
    /// - Returns: A product URL to the App Store.
    public static func productURL(with appStoreID: String) -> URL? {
        return URL(string: productURLString(with: appStoreID))
    }
    
    /// Tells StoreKit to ask the user to rate or review your app, if appropriate.
    ///
    /// This is a convenient wrapper method for `SKStoreReviewController.requestReview()` and `SKStoreReviewController.requestReview(in: UIWindowScene)`.
    @available(iOS 10.3, *)
    public static func requestReview() {
        let block = {
            if #available(iOS 14.0, *) {
                guard let windowScene = UIApplication.shared.connectedScenes
                    .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
                else {
                    Swift.print("AppStoreReviewManager couldn't find a foreground active window scene to request review alert!")
                    return
                }
                SKStoreReviewController.requestReview(in: windowScene)
            } else {
                SKStoreReviewController.requestReview()
            }
        }
        
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
    
    /// Automatically open the App Store product page and present a write review form in the App Store.
    /// - Parameter appStoreID: The App Store ID of a product.
    public static func openProductPageForReview(with appStoreID: String) {
        let urlString = productURLString(with: appStoreID) + "?action=write-review"
        guard let writeReviewURL = URL(string: urlString) else {
            assertionFailure("Expected a valid URL, \(urlString) is not a valid url string.")
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(writeReviewURL)
        }
    }
}
