//
//  ImSh_UISearchBar.swift
//  ImShExtensions
//
//  Created by Imran Mohammed on 10/20/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    /// To change text font
    ///
    /// - Parameter textFont: UIFont?
    public func change(textFont : UIFont?) {
        for view : UIView in (self.subviews[0]).subviews {
            if let textField = view as? UITextField {
                textField.font = textFont
            }
        }
    }
    
}
