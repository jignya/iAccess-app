//
//  SPLASH.swift


import UIKit

class SPLASH: UIViewController {

    @IBOutlet var lblBefore: UILabel!
    @IBOutlet var imgLogo: UIImageView!
    @IBOutlet var lblAppName: UILabel!
    
    @IBOutlet var btnYes: UIButton!
    @IBOutlet var btnOkay: UIButton!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var lblWouldyou: UILabel!
    @IBOutlet var imgUserfolder: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        btnYes.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnOkay.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        
        
//        ServerRequest.shared.getApiData(urlString: "accommodation.php", param: [:]) { result in
//        }
                
    }
    
    override func viewWillAppear(_ animated: Bool) {

        self.navigationController?.navigationBar.isHidden = true
        
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        style.headIndent = 20

    
        let title = NSMutableAttributedString(string: "Creating an account allows you to:", attributes: [.paragraphStyle: style,.foregroundColor:UIColor.black,.font:UIFont.roboto(size: 17, weight: .Medium) as Any])

        let titleStr = NSMutableAttributedString(string: "\n\u{2022} Save your medical conditions.\n\u{2022} Save relevant accessibility accommodations.\n\u{2022} Easily refer to your saved content in your profile.", attributes: [.paragraphStyle: style,.foregroundColor:UIColor.black,.font:UIFont.roboto(size: 14, weight: .Regular) as Any])
        
        title.append(titleStr)
        lblDesc.attributedText = title
    }
    

    @IBAction func btnOkayClick(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "Dashboard", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
        AppDelegate.shared.window?.rootViewController = navigationController
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func btnYesClick(_ sender: Any) {
        
        let login = self.storyboard?.instantiateViewController(withIdentifier: "SIGNUP") as! SIGNUP
        self.navigationController?.pushViewController(login, animated: true)
        
    }
        
}

