//
//  SIGNUP.swift
//  iACCESS
//
//  Created by Jignya Panchal on 01/10/24.
//

import UIKit

class SIGNUP: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet var btnback: UIButton!

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!

    @IBOutlet weak var lblAppname: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblFirstname: UILabel!
    @IBOutlet weak var lblLastname: UILabel!
    
    @IBOutlet var btnLogin: UIButton!


    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
      
        btnNext.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnback.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        
        btnLogin.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        
        txtUsername.keyboardType = .asciiCapable
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        self.txtUsername.delegate = self
        self.txtFirstname.delegate = self
        self.txtLastname.delegate = self
        
        self.lblUsername.setLabelValue(" Username * ")
        self.lblFirstname.setLabelValue(" Firstname * ")
        self.lblLastname.setLabelValue(" Lastname * ")

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - button Actions
    
    @IBAction func btnLoginClick(_ sender: UIButton)
    {
        self.view.endEditing(true)

        let login = self.storyboard?.instantiateViewController(withIdentifier: "LOGIN") as! LOGIN
        self.navigationController?.pushViewController(login, animated: true)

    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {

        self.view.endEditing(true)

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        if txtUsername.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter username", duration: .lengthShort).show()
            return

        } else if txtUsername.text?.count ?? 0 < 3 {
            SnackBar.make(in: self.view, message: "Username should be more than 3 characters", duration: .lengthShort).show()
            return

        }
        else if txtFirstname.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter firstname", duration: .lengthShort).show()
            return

        }
        else if txtLastname.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter lastname", duration: .lengthShort).show()
            return
        }
        else {
            
            self.view.endEditing(true)
            
            UserSettings.shared.userSignUpData.updateValue(self.txtUsername.text!, forKey: "username")
            UserSettings.shared.userSignUpData.updateValue(self.txtFirstname.text!, forKey: "firstname")
            UserSettings.shared.userSignUpData.updateValue(self.txtLastname.text!, forKey: "lastname")
            
            let login = self.storyboard?.instantiateViewController(withIdentifier: "LOGINEMAIL") as! LOGINEMAIL
            self.navigationController?.pushViewController(login, animated: true)

        }
    }
    
   
    
    // MARK: - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
       
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    

}
