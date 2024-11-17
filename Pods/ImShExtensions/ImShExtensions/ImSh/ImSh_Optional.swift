//
//  ImSh_Optional.swift
//  ImShExtensions
//
//  Created by Imran Mohammed on 10/20/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import UIKit

extension Optional where Wrapped == String {

    public var explicit: String {
        return self ?? ""
    }
    
}

extension Optional where Wrapped == Int {
    
    public var explicit: Int {
        return self ?? 0
    }
    
}

extension Optional where Wrapped == CGFloat {
    
    public var explicit: CGFloat {
        return self ?? 0.0
    }
    
}
