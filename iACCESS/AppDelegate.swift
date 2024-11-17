//
//  AppDelegate.swift
//  iACCESS


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = nil
    
    fileprivate var reach:Reachability!
    var isInternetConnected: Bool!
    var NoInternet : NoInternetVC! = nil

    
    static var shared: AppDelegate = {
        return UIApplication.shared.delegate as! AppDelegate
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize the window and set root view controller
        
        if UserSettings.shared.isLoggedIn()
        {
            window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DASHBOARD") as! DASHBOARD
            let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
            navigationController.viewControllers = [vc]
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
        else
        {
            window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SPLASH") as! SPLASH
            let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
            navigationController.viewControllers = [vc]
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
        
        return true
    }


}

