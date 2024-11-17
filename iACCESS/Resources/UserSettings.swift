//
//  UserSettings.swift
//

import Foundation
import UIKit

class UserSettings: NSObject {
    
    static let shared = UserSettings()
    var tabbarController = CustomTabbarVC()
    var arrCatList = [[String:Any]]()
    var arrCatListTemp = [[String:Any]]()  // clone of initial data to reset if needed

    var arrSubCatList = [[String:Any]]()
    var arrSubCatListTemp = [[String:Any]]()  // clone of initial data to reset if needed
    
    var arrSubCatMedicalList = [[String:Any]]()
    var arrLetters = [String]()
    
    var userSignUpData = [String:Any]()



    
//    class google {
//        static let clientId: String = "643263723729-8q6g4t3k7dq6sdqomdm9ied0i9vapuke.apps.googleusercontent.com"
//        let ss = "com.googleusercontent.apps.643263723729-8q6g4t3k7dq6sdqomdm9ied0i9vapuke"
//    }
    
//    class pushToken {
//        static var token: String {
//            set(newValue) {
//                newValue.cache(key: "_devicePushToken")
//            }
//            get {
//                return String.cached(key: "_devicePushToken") ?? "Not Determined"
//            }
//        }
//    }
//
//    class FcmToken {
//        static var token: String {
//            set(newValue) {
//                newValue.cache(key: "_deviceFcmToken")
//            }
//            get {
//                return String.cached(key: "_deviceFcmToken") ?? " "
//            }
//        }
//    }
    

    /// User related functions
    func setLoggedIn() {
        true.cache(key: "authUserIsLoggedIn")
        
        // Post notification
        NotificationCenter.default.post(name: Notification.Name.ImShLoginStatusChanged, object: nil, userInfo: nil)
    }

    func setLoggedOut() {
        // Logout from facebook
//        let fbManager = LoginManager.init()
//        fbManager.logOut()
//
//        // Logout from google
//        GIDSignIn.sharedInstance()?.signOut()
        
        false.cache(key: "authUserIsLoggedIn")
        
        
        // Post notification
        NotificationCenter.default.post(name: Notification.Name.ImShLoginStatusChanged, object: nil, userInfo: nil)
    }
    
    func isLoggedIn() -> Bool {
        return Bool.cached(key: "authUserIsLoggedIn")
    }
    

    func setUserId(userId: String) {
        let userDef = UserDefaults.standard
        userDef.set(userId, forKey: "userId")
        userDef.synchronize()
    }
    func getUserId() -> String {
        return UserDefaults.standard.value(forKey: "userId") as? String  ?? "12"
    }

    func setUserCredential(strEmail: String, strPassword: String) {
        let userDef = UserDefaults.standard
        userDef.set(strEmail, forKey: "userLoginEmail")
        userDef.set(strPassword, forKey: "userLoginPass")
        userDef.synchronize()
    }
    
    func getUserCredential() -> Dictionary<String, Any> {

        let strEmail = UserDefaults.standard.string(forKey: "userLoginEmail") ?? ""
        let strPass = UserDefaults.standard.string(forKey: "userLoginPass") ?? ""

        let params = [
            "username": strEmail,
            "password": strPass
        ] as Dictionary
        
        return params

        
    }

    func themeColor() -> UIColor {
        return UIColor(red: 49.0/255.0, green: 184.0/255.0, blue: 183.0/255.0, alpha: 1)
    }

    func themeColor2() -> UIColor {
        return UIColor(red: 4.0/255.0, green: 14.0/255.0, blue: 69.0/255.0, alpha: 1)
    }
    
    func ScreentitleColor() -> UIColor {
        return UIColor(red: 50.0/255.0, green: 58.0/255.0, blue: 69.0/255.0, alpha: 1)
    }
    
    func ThemeGrayColor() -> UIColor {
        return UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1)
    }
    
    func ThemeBgGroupColor() -> UIColor {
        return UIColor(red: 244.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, alpha: 1)
    }
    
    func ThemeBorderColor() -> UIColor {
        return UIColor(red: 230.0/255.0, green: 232.0/255.0, blue: 244.0/255.0, alpha: 1)
    }
    
    

}

extension Notification.Name {
    
    static let ImShLoginStatusChanged = Notification.Name.init("ImShLoginStatusChanged")
    
}
