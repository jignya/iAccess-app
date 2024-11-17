//
//  ImSh_CGFloat.swift
//  ImShExtensions
//
//  Created by Imran Mohammed on 11/1/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    /// To get percentage for value from 0.0 - 1.0
    public var toPercent: CGFloat {
        return self * 100.0
    }
    
}
