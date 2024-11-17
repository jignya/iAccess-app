//
//  AlamofireManager.swift
//  Omahat
//
//  Created by Imran Mohammed on 3/5/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireManager: SessionManager {
    
    static let shared = AlamofireManager()
    
    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = 60
        config.timeoutIntervalForRequest = 60
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.httpShouldSetCookies = false
        super.init(configuration: config)
    }

}
