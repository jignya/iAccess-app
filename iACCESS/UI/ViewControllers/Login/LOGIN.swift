//
//  LOGIN.swift
//

import UIKit

class LOGIN: UIViewController ,UITextFieldDelegate,ServerRequestDelegate {
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet var btnback: UIButton!
    
    @IBOutlet var btnDontHaveAccount: UIButton!
    
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblAppname: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    
    var strcomeFrom: String = ""
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
        
        btnNext.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnback.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnDontHaveAccount.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        self.txtUsername.delegate = self
        self.txtPassword.delegate = self
        
        self.lblUsername.setLabelValue(" Username * ")
        self.lblPassword.setLabelValue(" Password * ")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - button Actions
    
    @IBAction func btnBackClick(_ sender: UIButton) {
        
        if strcomeFrom == "side"{
            self.view.endEditing(true)
            let storyboard = UIStoryboard.init(name: "Dashboard", bundle: nil)
            let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
            AppDelegate.shared.window?.rootViewController = navigationController
            AppDelegate.shared.window?.makeKeyAndVisible()
            
        } else
        {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func btnDontHaveAccountClick(_ sender: UIButton)
    {
        if strcomeFrom == "side"{
            let login = self.storyboard?.instantiateViewController(withIdentifier: "SIGNUP") as! SIGNUP
            self.navigationController?.pushViewController(login, animated: true)
            
        } else
        {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnNextClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        if txtUsername.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter username", duration: .lengthShort).show()
            return
            
        }
        else if txtPassword.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter password", duration: .lengthShort).show()
            return
            
        } else {
            
            self.view.endEditing(true)
            
            self.loginUser(strUsername: self.txtUsername.text!, strPassword: self.txtPassword.text!)
        }
    }
    
    
    
    // MARK: - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    // MARK: ServerRequestDelegate
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...")
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
    
    //MARK: - Api call
    
    func loginUser(strUsername: String,strPassword: String) {
        
        let param = ["username":strUsername,"password":strPassword]
        ServerRequest.shared.postApiData(urlString: "signin.php", params: param, delegate: self) { result in
            
            DispatchQueue.main.async {
                
                print(result)
                UserSettings.shared.setLoggedIn()
                let storyboard = UIStoryboard.init(name: "Dashboard", bundle: nil)
                let navigationController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
                AppDelegate.shared.window?.rootViewController = navigationController
                AppDelegate.shared.window?.makeKeyAndVisible()
            }
        }
        
    }
    
}

extension UILabel {
    
    func setLabelValue(_ textName: String) {
        
        let range = (textName as NSString).range(of: "*")
        let attributedString = NSMutableAttributedString(string:textName)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        
        //Apply to the label
        self.attributedText = attributedString;
        
    }
}
