//
//  CONFIRMATION.swift
//  iACCESS
//
//  Created by Jignya Panchal on 21/09/24.
//

import UIKit

class CONFIRMATION: UIViewController,ServerRequestDelegate {
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnChangeEmail: UIButton!
    @IBOutlet var btnResend: UIButton!

    @IBOutlet weak var lblConfirmemail: UILabel!
    @IBOutlet weak var lblAppname: UILabel!
    @IBOutlet weak var lblDesc: UILabel!

    @IBOutlet weak var txtCode: UITextField!


    var strEmail : String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Globally font application
        CommonFunction.shared.setFontFamily(for: self.view, andSubViews: true)
      
        btnContinue.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnChangeEmail.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)
        btnResend.titleLabel?.font =  UIFont.roboto(size: 17, weight: .Medium)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        self.lblDesc.text = "A confirmation email has been sent to " + strEmail

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ServerRequestDelegate
    func isLoading(loading: Bool) {
        if loading {
            ImShSwiftLoader.shared.show("Please wait...")
        } else {
            ImShSwiftLoader.shared.hide()
        }
    }
    
    // MARK: - button Actions
    
    @IBAction func btnResendClick(_ sender: UIButton) {
        
        let param = ["email":strEmail]
        ServerRequest.shared.getApiData(urlString: "resend_code.php", param: param, delegate: self) { (result,response) in
            
            DispatchQueue.main.async {
                
                print(result)
                
                AJAlertController.initialization().showAlertWithOkButton(isBottomShow: false, aStrTitle: "Success", aStrMessage: "Code has been sent to your email address", aOKBtnTitle: "Okay") { index, title in
                }

            }
        }
        
    }
   
    @IBAction func btnchangeEmailClick(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnContinueClick(_ sender: UIButton)
    {
        if txtCode.text?.count == 0
        {
            SnackBar.make(in: self.view, message: "Please enter code you have received in your email", duration: .lengthShort).show()
            return
        }
        else {
            
            self.view.endEditing(true)
//            self.verifyEmail(strEmail: self.strEmail, strCode: self.txtCode.text!)
            
            let otp = self.storyboard?.instantiateViewController(withIdentifier: "LOCATION") as! LOCATION
            self.navigationController?.pushViewController(otp, animated: true)

            
        }
    }
    
   
    
    // MARK: - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
        
    }

    
    //MARK: - Api call
    
    func verifyEmail(strEmail: String,strCode: String) {
        
        let param = ["email":strEmail,"code":strCode]
        ServerRequest.shared.postApiData(urlString: "verified_code.php", params: param, delegate: self) { result in
            
            DispatchQueue.main.async {
                
                print(result)
                let otp = self.storyboard?.instantiateViewController(withIdentifier: "LOCATION") as! LOCATION
                self.navigationController?.pushViewController(otp, animated: true)
            }
        }
        
    }
}
