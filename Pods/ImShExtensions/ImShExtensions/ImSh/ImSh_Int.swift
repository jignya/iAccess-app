//
//  ImSh_Int.swift
//  ImShExtensions
//
//  Created by Imran Mohammed on 10/20/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import UIKit

extension Int {
    
    /// To convert number to days
    public var days: TimeInterval {
        return TimeInterval(self * 24 * 60 * 60)
    }
    
    /// To convert number to hours
    public var hours: TimeInterval {
        return TimeInterval(self * 60 * 60)
    }
    
    /// To convert number to minutes
    public var minutes: TimeInterval {
        return TimeInterval(self * 60)
    }
    
    /// To convert number to string
    public func toString() -> String {
        return String(self)
    }
    
}
