//
//  ImSh_UIViewController.swift
//  ImShExtensions
//
//  Created by Imran Mohammed on 10/20/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// To delay the execution with completion handler
    ///
    /// - Parameters:
    ///   - seconds: Double
    ///   - completion: Handler
    public func delaySec(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    /// To block UI, with auto unblock timer
    ///
    /// - Parameters:
    ///   - block: Boolean
    ///   - autoUnblockTime: Double
    public func blockUI(block: Bool, autoUnblockTime: Double? = nil) {
        let defApp = UIApplication.shared
        block ? defApp.beginIgnoringInteractionEvents() : defApp.endIgnoringInteractionEvents()

        guard let unblockTime = autoUnblockTime else { return }
        self.delaySec(unblockTime) {
            defApp.endIgnoringInteractionEvents()
        }
    }
    
    /// Tap gesture to dismiss keyboard
    ///
    /// - Returns: UITapGestureRecognizer
    public func tapG_dismissKeyboard() -> UITapGestureRecognizer {
        let tapG: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        return tapG
    }
    
    /// Dismiss keyboard
    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// To get top view controller
    static public var top: UIViewController? {
        get {
            return topViewController()
        }
    }
    
    /// To get root view controller
    static public var root: UIViewController? {
        get {
            return UIApplication.shared.delegate?.window??.rootViewController
        }
    }
    
    /// To get top view controller
    ///
    /// - Parameter viewController: viewController
    /// - Returns: UIViewController?
    static public func topViewController(from viewController: UIViewController? = UIViewController.root) -> UIViewController? {
        if let tabBarViewController = viewController as? UITabBarController {
            return topViewController(from: tabBarViewController.selectedViewController)
        } else if let navigationController = viewController as? UINavigationController {
            return topViewController(from: navigationController.visibleViewController)
        } else if let presentedViewController = viewController?.presentedViewController {
            return topViewController(from: presentedViewController)
        } else {
            return viewController
        }
    }
    
    /// To open any URL
    ///
    /// - Parameter urlString: String
    /// - Returns: Boolean
    public func openUrl(urlString: String) -> Bool {
        if let urlLink = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(urlLink) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(urlLink, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(urlLink)
                }
            } else { return false }
        } else { return false }
        return true
    }

    /// To make a direct phone call
    ///
    /// - Parameters:
    ///   - number: String
    ///   - withPrompt: Boolean
    public func makeACall(number: String, withPrompt: Bool = false) {
        if withPrompt {
            _ = self.openUrl(urlString: "telprompt://\(number)")
        } else {
            _ = self.openUrl(urlString: "tel://\(number)")
        }
    }
    
    /// To open rating in AppStore
    ///
    /// - Parameter appId: String
    public func openRatingInAppStore(appId: String) {
        _ = self.openUrl(urlString: "https://itunes.apple.com/app/id\(appId)?mt=8&action=write-review")
    }
    
    /// To open app in AppStore
    ///
    /// - Parameter appId: String
    public func openAppStore(appId: String) {
        let appStoreUrl = "https://itunes.apple.com/app/id\(appId)?mt=8"
        _ = self.openUrl(urlString: appStoreUrl)
    }
    
    /// To share anything via App Default Share
    ///
    /// - Parameters:
    ///   - objectsAre: [Any]
    ///   - sender: AnyObject
    public func shareObjectsViaActivityVC(objectsAre: [Any], sender: AnyObject) {
        let activityVC = UIActivityViewController(activityItems: objectsAre, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = sender as? UIView
        self.present(activityVC, animated: true, completion: nil)
    }
    
    /// To print all the font names in the app
    public func writeFontNames() {
        for familyName in UIFont.familyNames {
            print("#\(familyName)")
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("\tFont: \(fontName)")
            }
        }
    }
    
    /// To show/hide network indicator
    ///
    /// - Parameter show: Boolean
    public func networkIndicator(show: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = show
        }
    }
    
    public func showAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style = .alert, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: preferredStyle)
        let dismissAction = UIAlertAction.init(title: "Dismiss", style: .cancel, handler: handler)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
