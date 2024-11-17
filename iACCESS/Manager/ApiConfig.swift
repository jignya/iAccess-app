//
//  ApiConfig.swift
//  Omahat
//
//  Created by Imran Mohammed on 3/5/19.
//  Copyright © 2019 ImSh. All rights reserved.
//

import Foundation

class ApiConfig: NSObject {
    
    static let shared = ApiConfig()
    
    private override init() {}
    
    // BASE URL AND API PATH

    fileprivate let baseUrl = "http://dev2.omahat.net/"   //- test
//    fileprivate let baseUrl = "https://omahat.net/"  // live

    fileprivate let apiPath = "rest/V1"
    fileprivate let apiArPath = "rest/ar/V1"
    
    fileprivate func getApiBaseLink() -> String {
        let language = ImShLanguage.shared.get()
        switch language {
        case .english:
            var str1 = UserSettings.shared.getBaseUrl()
            if str1 == ""
            {
                str1 = "\(baseUrl)\(apiPath)"
            }
            return str1
        case .arabic:
//            return "\(baseUrl)rest/ar/V1"
            var str1 = UserSettings.shared.getBaseArUrl()
            if str1 == ""
            {
                str1 = "\(baseUrl)\(apiArPath)"
            }
            return str1
        }
    }
    
    func getApiBaseUrl() -> String {
        return baseUrl
    }
    
    func getApiURL(_ apiPath: ApiPath, route: ApiRoute? = nil) -> URL {
        if let r = route
        {
            if apiPath == .guestCustomer  // for push
            {
                let urlStr = "\(getApiBaseLink())/\(r.rawValue)/guest/customers"
                return urlStr.getURL!

            }
            else if apiPath == .countries  // for countries
            {
                let urlStr = "\(getApiBaseLink())/\(r.rawValue)/gcc/countries"
                return urlStr.getURL!

            }
            else
            {
                let urlStr = "\(getApiBaseLink())/\(r.rawValue)/\(apiPath.rawValue)"
                return urlStr.getURL!

            }
            
        }
        else
        {
            let urlStr = "\(getApiBaseLink())/\(apiPath.rawValue)"
            return urlStr.getURL!
        }
    }
    
    func getApiURL(_ apiPath: ApiPath, route: ApiRoute? = nil, subDir: [String]) -> URL {
        var urlStr = getApiURL(apiPath, route: route).absoluteString
        for dir in subDir {
            urlStr += "/\(dir)"
        }
        return urlStr.getURL!
    }
    
    
    
    func getApiURL(_ apiPath: ApiPath, route: ApiRoute? = nil, subDir: [String], params: [String: String]) -> URL {
        var urlStr = getApiURL(apiPath, route: route, subDir: subDir).absoluteString
        for (index, param) in params.enumerated() {
            if index == 0 {
                urlStr += "?"
            }
            urlStr += "\(param.key)=\(param.value)&"
        }
        urlStr.removeLast()
        return urlStr.getURL!
    }
    
//    func getDiscountCouponUrl(quoteId: String ,tail: String) -> URL? {
////        http://omahat.net/rest/V1/carts/209257/coupons/T10
//        let strurl = baseUrl + "rest/V1/carts/" + quoteId + "/coupons/" + tail
//        print(strurl)
//        let url1 = URL(string: strurl)!
//        return url1
//    }
    
    func getProductUrl(tail: String) -> URL? {
//        return ("http://omahat.net/pub/media/catalog/product/" + tail).getURL
        return (baseUrl + "pub/media/catalog/product/" + tail).getURL
//        return ("http://omahat.net/staging/pub/media/catalog/product/" + tail).getURL
    }
    
    func getCategoryUrl(tail: String) -> URL?{
        return (baseUrl + "pub/media/catalog/category/" + tail).getURL
//        return ("http://omahat.net/pub/media/catalog/category/" + tail).getURL
//        return ("http://omahat.net/staging/pub/media/catalog/category/" + tail).getURL

    }
    
    func getMaintenanceUrl(tail: String) -> String?{
        return (baseUrl + "maintenancemode.php" + tail)

        }
    
}
