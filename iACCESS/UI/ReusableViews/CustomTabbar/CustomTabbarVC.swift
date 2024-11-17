//
//  CustomTabbarVC.swift
//

import UIKit

class CustomTabbarVC: UIViewController
{
    
    @IBOutlet weak var lblLine: UILabel!
    @IBOutlet weak var conlbllineLeading: NSLayoutConstraint!

    @IBOutlet weak var imgHome: UIImageView!
    @IBOutlet weak var imgJob: UIImageView!
    @IBOutlet weak var imgExplore: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblHome: UILabel!
    @IBOutlet weak var lblJob: UILabel!
    @IBOutlet weak var lblExplore: UILabel!
    @IBOutlet weak var lblProfile: UILabel!

    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnJob: UIButton!
    @IBOutlet weak var btnExplore: UIButton!
    @IBOutlet weak var btnProfile: UIButton!

    var storyboard1 = UIStoryboard()
    
    var tab :Int!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        lblHome.text = "HOME"
        lblJob.text = "JOBS"
        lblExplore.text = "EXPLORE"
        lblProfile.text = "PROFILE"
        
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)

    }
    
    override func viewWillLayoutSubviews() {
        let lastposition = UserDefaults.standard.value(forKey: "lastindex") as? CGFloat ?? 0.0
        self.conlbllineLeading.constant = lastposition
        
        updatelayout(index:tab)

    }

    
    func updatelayout(index:Int)
    {
        
        let width = self.view.frame.size.width / 4
        let position = width * CGFloat(index)
        
//        print(width,position,lastposition)

        if index == 0
        {
            imgHome.tintColor = UserSettings.shared.themeColor()
            imgJob.tintColor = UIColor.lightGray
            imgExplore.tintColor = UIColor.lightGray
            imgProfile.tintColor = UIColor.lightGray
            

            UIView.animate(withDuration: 0.3) {
                self.conlbllineLeading.constant = (self.view.frame.width / 4) * CGFloat(index)
                UserDefaults.standard.setValue(self.conlbllineLeading.constant, forKey: "lastindex")
                self.lblHome.isHidden = false
                self.lblLine.updateConstraintsIfNeeded()
//                self.lblLine.layoutIfNeeded()
            }
            
            lblJob.isHidden = true
            lblExplore.isHidden = true
            lblProfile.isHidden = true
        }
        else if index == 1
        {
            imgHome.tintColor = UIColor.lightGray
            imgJob.tintColor = UserSettings.shared.themeColor()
            imgExplore.tintColor = UIColor.lightGray
            imgProfile.tintColor = UIColor.lightGray
            
            UIView.animate(withDuration: 0.3) {

                self.conlbllineLeading.constant = position

                UserDefaults.standard.setValue(self.conlbllineLeading.constant, forKey: "lastindex")
                self.lblJob.isHidden = false
                self.lblLine.updateConstraintsIfNeeded()
//                self.lblLine.layoutIfNeeded()

            }
            
            lblHome.isHidden = true
            lblExplore.isHidden = true
            lblProfile.isHidden = true
        }
        else if index == 2
        {
            imgHome.tintColor = UIColor.lightGray
            imgJob.tintColor = UIColor.lightGray
            imgExplore.tintColor = UserSettings.shared.themeColor()
            imgProfile.tintColor = UIColor.lightGray
            
            
            UIView.animate(withDuration: 0.3) {
                self.conlbllineLeading.constant = (self.view.frame.width / 4) * CGFloat(index)
                UserDefaults.standard.setValue(self.conlbllineLeading.constant, forKey: "lastindex")
                self.lblExplore.isHidden = false
                self.lblLine.updateConstraintsIfNeeded()
//                self.lblLine.layoutIfNeeded()

            }
            
            lblHome.isHidden = true
            lblJob.isHidden = true
            lblProfile.isHidden = true
        }
        else
        {
            imgHome.tintColor = UIColor.lightGray
            imgJob.tintColor = UIColor.lightGray
            imgExplore.tintColor = UIColor.lightGray
            imgProfile.tintColor = UserSettings.shared.themeColor()
            

            UIView.animate(withDuration: 0.3 ) {
                self.conlbllineLeading.constant = (self.view.frame.width / 4) * CGFloat(index)
                UserDefaults.standard.setValue(self.conlbllineLeading.constant, forKey: "lastindex")
                self.lblProfile.isHidden = false
                self.lblLine.updateConstraintsIfNeeded()
//                self.lblLine.layoutIfNeeded()

            }
            
            lblHome.isHidden = true
            lblJob.isHidden = true
            lblExplore.isHidden = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
//        Manager.sharedInstance.setFontFamily("", for: self.view, andSubViews: true)
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Action
    @IBAction func btnHomeClick(_ sender: Any)
    {
//        self.updatelayout(index: 0)

        if UserDefaults.standard.bool(forKey: "arabic")
        {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else
        {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        storyboard1 = UIStoryboard(name: "Home", bundle: nil)
//        let home = storyboard1.instantiateViewController(withIdentifier: "HOME") as! HOME
        let navigationController = storyboard1.instantiateViewController(withIdentifier: "nav") as! UINavigationController
//        navigationController.isNavigationBarHidden = false
//        navigationController.setViewControllers([home], animated: false)
        AppDelegate.shared.window?.rootViewController = navigationController
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    @IBAction func btnJobClick(_ sender: Any)
    {
//        self.updatelayout(index: 1)

        if UserDefaults.standard.bool(forKey: "arabic")
        {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else
        {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        storyboard1 = UIStoryboard(name: "Jobs", bundle: nil)
        let navigationController = storyboard1.instantiateViewController(withIdentifier: "nav") as! UINavigationController
//        navigationController.isNavigationBarHidden = false
//        navigationController.setViewControllers([home], animated: false)
        AppDelegate.shared.window?.rootViewController = navigationController
        AppDelegate.shared.window?.makeKeyAndVisible()

    }
    
    @IBAction func btnExploreClick(_ sender: Any)
    {
//        self.updatelayout(index: 2)

        if UserDefaults.standard.bool(forKey: "arabic")
        {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else
        {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        storyboard1 = UIStoryboard(name: "Explore", bundle: nil)
//        let home = storyboard1.instantiateViewController(withIdentifier: "HOME") as! HOME
        let navigationController = storyboard1.instantiateViewController(withIdentifier: "nav") as! UINavigationController
//        navigationController.isNavigationBarHidden = false
//        navigationController.setViewControllers([home], animated: false)
        AppDelegate.shared.window?.rootViewController = navigationController
        AppDelegate.shared.window?.makeKeyAndVisible()

    }
    
    @IBAction func btnProfileClick(_ sender: Any)
    {
//        self.updatelayout(index: 3)

        if UserDefaults.standard.bool(forKey: "arabic")
        {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else
        {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        storyboard1 = UIStoryboard(name: "Profile", bundle: nil)
//        let home = storyboard1.instantiateViewController(withIdentifier: "HOME") as! HOME
        let navigationController = storyboard1.instantiateViewController(withIdentifier: "nav") as! UINavigationController
//        navigationController.isNavigationBarHidden = false
//        navigationController.setViewControllers([home], animated: false)
        AppDelegate.shared.window?.rootViewController = navigationController
        AppDelegate.shared.window?.makeKeyAndVisible()

    }
   
}
