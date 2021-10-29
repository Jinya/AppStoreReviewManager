//
//  AppStoreReviewManager
//  https://github.com/Jinya/AppStoreReviewManager
//
//  Created by Jinya on 2021/10/29.
//
//  Copyright (c) 2021 Jinya<https://github.com/Jinya>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import StoreKit

public struct AppStoreReviewManager {
    
    private static let baseURLString = "https://apps.apple.com/app/"
    
    /// Get the App Store page url string for your app
    /// - Parameter id: the App Store ID for your app, you can find the App Store ID in your app's product URL
    /// - Returns: the App Store page url string for your app
    public static func appStorePageURLString(with id: String) -> String {
        return baseURLString + "id\(id)"
    }
    
    /// Request StoreKit to ask the user to rate or review your app, users will submit a rating through the standardized prompt, and can write and submit a review without leaving the app. You can prompt for ratings up to three times in a 365-day period.
    public static func requestReviewInApp() {
        let task = {
            if #available(iOS 14.0, *) {
                let keyWindow = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).flatMap { $0.windows }.first { $0.isKeyWindow }
                guard let windowScene = keyWindow?.windowScene else {
                    assertionFailure("AppStoreReviewManager can't find key window of the app!")
                    return
                }
                SKStoreReviewController.requestReview(in: windowScene)
            } else if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            } else {
                #if DEBUG
                print("This operation is not supported on systems older than iOS 10.3")
                #endif
            }
        }
        
        if Thread.isMainThread {
            task()
        } else {
            DispatchQueue.main.async {
                task()
            }
        }
    }
    
    /// To enable a user to initiate a review as a result of an action in the UI use a deep link to the App Store page for your app with the query parameter action=write-review appended to the URL.
    /// - Parameter id: the App Store ID for your app, you can find the App Store ID in your app's product URL
    public static func requestReviewInAppStore(with id: String) {
        let urlString = baseURLString + "id\(id)?action=write-review"
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
    
    /// Use a deep link to open the App Store page for your app.
    /// - Parameter id: the App Store ID for your app, you can find the App Store ID in your app's product URL
    public static func openAppStorePage(with id: String) {
        let urlString = appStorePageURLString(with: id)
        guard let appStorePageURL = URL(string: urlString) else {
            assertionFailure("Expected a valid URL, \(urlString) is not a valid url string.")
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(appStorePageURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(appStorePageURL)
        }
    }
    
}
