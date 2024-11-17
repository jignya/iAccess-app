//
//  LOGINEMAIL.swift
//  iACCESS
//
//  Created by Jignya Panchal on 21/09/24.
//

import UIKit
import ImShExtensions

class LOGINEMAIL: UIViewController,UITextFieldDelegate, ServerRequestDelegate {
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet var btnback: UIButton!

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCreatePW: UITextField!
    @IBOutlet weak var txtConfirmPW: UITextField!

    @IBOutlet weak var lblAppname: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCreatePW: UILabel!
    @IBOutlet weak var lblConfirmPW: UILabel!


    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
      
        btnNext.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnback.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        self.txtEmail.delegate = self
        self.txtCreatePW.delegate = self
        self.txtConfirmPW.delegate = self

        self.lblEmail.setLabelValue(" Email * ")
        self.lblCreatePW.setLabelValue(" Create Password * ")
        self.lblConfirmPW.setLabelValue(" Confirm Password * ")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - button Actions
    
    @IBAction func btnBackClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        if txtEmail.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter email", duration: .lengthShort).show()

        } else if txtEmail.text?.isValidEmail == false
        {
            SnackBar.make(in: self.view, message: "Please enter valid email", duration: .lengthShort).show()
            return
            
        } else if txtCreatePW.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter password", duration: .lengthShort).show()

        } else if txtCreatePW.text?.count ?? 0 < 6 {
            SnackBar.make(in: self.view, message: "Password should be more than 6 characters", duration: .lengthShort).show()
            return

        }
        else if txtConfirmPW.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter confirm password", duration: .lengthShort).show()
            
        } else if txtConfirmPW.text != txtCreatePW.text
        {
            SnackBar.make(in: self.view, message: "Password does not match", duration: .lengthShort).show()
        }
        else {
         
            self.view.endEditing(true)
            
            UserSettings.shared.userSignUpData.updateValue(self.txtEmail.text!, forKey: "email")
            UserSettings.shared.userSignUpData.updateValue(self.txtConfirmPW.text!, forKey: "password")
            
//            self.sendVerificationCode(strEmail: self.txtEmail.text!)

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CONFIRMATION") as! CONFIRMATION
            vc.strEmail = self.txtEmail.text ?? ""
            self.navigationController?.pushViewController(vc, animated: true)

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
    
    //MARK: - APi call
    
    func sendVerificationCode(strEmail:String)
    {
        let param = ["email":strEmail]
        ServerRequest.shared.postApiData(urlString: "sendVerificationCode.php", params: param, delegate: self) { result in
            
            DispatchQueue.main.async {
                
                print(result)
                
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "Success", aStrMessage: "Code has been sent to your email address", aOKBtnTitle: "Okay") { index, title in
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CONFIRMATION") as! CONFIRMATION
                    vc.strEmail = self.txtEmail.text ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)

                }

            }
        }
        
    }

}
