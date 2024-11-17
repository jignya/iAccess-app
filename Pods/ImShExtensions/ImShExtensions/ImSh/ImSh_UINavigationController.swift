//
//  ImSh_UINavigationController.swift
//  ImShExtensions
//
//  Created by Imran Mohammed on 10/20/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import UIKit

extension UINavigationController {

    /// To pop one level
    ///
    /// - Parameter animated: Boolean
    public func pop(animated: Bool = true) {
        _ = self.popViewController(animated: animated)
    }

    /// To pop to desired Class
    ///
    /// - Parameters:
    ///   - viewController: AnyClass
    ///   - animated: Boolean
    public func pop(to viewController: AnyClass, animated: Bool = true) {
        for vc in self.viewControllers {
            if vc.isKind(of: viewController.self) {
                self.popToViewController(vc, animated: animated)
            }
        }
    }

}
