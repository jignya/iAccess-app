//
//  ImSh_UIImageView.swift
//  ImShExtensions
//
//  Created by Imran Mohammed on 12/17/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
extension UIImageView {
    
    @IBInspectable var tint: UIColor {
        get {
            return self.tintColor
        }
        set (new) {
            self.image = image?.withRenderingMode(.alwaysTemplate)
            self.tintColor = new
        }
    }
    
}
