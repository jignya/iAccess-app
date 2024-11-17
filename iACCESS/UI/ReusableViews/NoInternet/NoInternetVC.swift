//
//  NoInternetVC.swift
//

import UIKit

class NoInternetVC: UIViewController
{
    @IBOutlet var lblNoInternet: UILabel!
    @IBOutlet var lblNoInternet1: UILabel!

    @IBOutlet var view1: UIView!
    @IBOutlet var btnTryAgain: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

//        Manager.sharedInstance.removeTabbar()
        
//        lblNoInternet.text = "No Internet"
    }
    override func viewWillLayoutSubviews()
    {
        lblNoInternet1.font = UIFont(name: "Calibri-Bold", size: 24)
        lblNoInternet.font = UIFont(name: "Calibri", size: 20)
        btnTryAgain.titleLabel?.font = UIFont(name: "Calibri", size: 18)
        
        lblNoInternet.text = "No internet connection!"
        lblNoInternet1.text = "Please check your network connection"
        btnTryAgain.setTitle("TRY AGAIN", for: .normal)

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnRetryClick(_ sender: AnyObject) {

        print("click")
        let app : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if(app.isInternetConnected == true)
        {//            let win:UIWindow = app.window!

            let subviews: NSArray = app.window!.subviews as NSArray
            for id in subviews
            {
                if(id as? UIView == self.view)
                {
                    DispatchQueue.main.async(execute: {
                        (id as AnyObject).removeFromSuperview()
                        print("Removed")
                        //                    break
                    })
                }
            }
        }
    }
    
}

