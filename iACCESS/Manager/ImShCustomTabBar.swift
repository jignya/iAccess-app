//
//  ImShCustomTabBar.swift
//


import UIKit

class DataSharingTabBarController: ImShCustomTabBar {
    var preSelectCatId: Int? = nil
    var brandIdFromPush: Int? = nil
    var itemTitle: String? = nil
    var strcome: String? = nil
}

class ImShCustomTabBar: TTabBarViewController,UITabBarControllerDelegate {
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        tabBar.unselectedItemTintColor = UIColor.gray
        tabBar.tintColor = UserSettings.shared.themeColor()
        
        UITabBarItem.appearance()
                
//        tabBar.unselectedItemTintColor = UIColor.white
//        tabBar.tintColor = UIColor.white
        self.delegate = self
        
        self.indicatorColor = UIColor.clear

        guard let tabItems = self.tabBar.items else { return }
        for (index, item) in tabItems.enumerated() {
            
            item.titlePositionAdjustment = UIOffset(horizontal: 0,vertical: -20)
            item.imageInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0)
            
            switch index {
            case 0:
                item.title = "HOME"
                item.selectedImage = UIImage(named: "home")
                item.image = UIImage(named: "home")
                self.indicatorColor = UserSettings.shared.themeColor()
            case 1:
                item.title = "JOB"
                item.selectedImage = UIImage(named: "job")
                item.image = UIImage(named: "job")
                self.indicatorColor = UserSettings.shared.themeColor()

            case 2:
                item.title = "EXPLORE"
                item.selectedImage = UIImage(named: "explore")
                item.image = UIImage(named: "explore")
                self.indicatorColor = UserSettings.shared.themeColor()

            case 3:
                item.title = "PROFILE"
                item.selectedImage = UIImage(named: "profile")
                item.image = UIImage(named: "profile")
                self.indicatorColor = UserSettings.shared.themeColor()

            default: break
            }
        }
    }
    
    @available(iOS 13.0, *)
    private func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.normal.iconColor = .lightGray
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        
        itemAppearance.selected.iconColor = UserSettings.shared.themeColor()
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }

    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        // Manage navigation flow direction

        if let navVC = viewController as? UINavigationController {
            navVC.view.semanticContentAttribute = UserDefaults.standard.bool(forKey: "isArabic") ? .forceRightToLeft : .forceLeftToRight
        }
        
        
    

//        // Allows scrolling to top on tab bar click
//        if let navVC = viewController as? UINavigationController, let vc = navVC.viewControllers.first as? HOME {
//            vc.scrollToTop()
//        }
//        //manage category root flow as curreny update not working
//        else if let navVC = viewController as? UINavigationController, let vc = navVC.viewControllers.first as? CATEGORIES
//        {
//            navVC.popToRootViewController(animated: true)
//        }

    
    }
    
}
