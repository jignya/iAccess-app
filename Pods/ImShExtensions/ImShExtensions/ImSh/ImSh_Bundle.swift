//
//  ImSh_Bundle.swift
//  ImShExtensions
//
//  Created by Imran Mohammed on 10/20/18.
//  Copyright © 2018 ImSh. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// To get release version number
    public var releaseVersionNumber: String {
        let relVer = infoDictionary?["CFBundleShortVersionString"] as? String
        return relVer ?? "1.0"
    }
    
    /// To get build version number
    public var buildVersionNumber: String {
        let buildVer = infoDictionary?["CFBundleVersion"] as? String
        return buildVer ?? "1"
    }
    
}
