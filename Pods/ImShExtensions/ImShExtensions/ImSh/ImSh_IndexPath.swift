//
//  ImSh_IndexPath.swift
//  ImShExtensions
//
//  Created by Imran Mohammed on 10/29/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import Foundation

extension IndexPath {
    
    /// To get the Zeroth item
    ///
    /// - Returns: IndexPath
    public static func zeroItem() -> IndexPath {
        return IndexPath(item: 0, section: 0)
    }
    
    /// To get the Zeroth row
    ///
    /// - Returns: IndexPath
    public static func zeroRow() -> IndexPath {
        return IndexPath(row: 0, section: 0)
    }
    
}
